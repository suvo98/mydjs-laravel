<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
//    public function __construct()
//    {
//        $this->middleware('auth:api', ['except' => ['login']]);
//    }


    public function GetSaveProfile(Request $request)
    {
        $data = DB::table('aca_stu_details')
            ->where('StudentID', $request->input('StudentID'))
            ->first();
        return [
            'data' => $data
        ];
    }

    public function saveProfile(Request $request)
    {
        $data = DB::table('aca_stu_details')
            ->select('id')
            ->where('StudentID', $request->input('StudentID'))
            ->first();
        $month = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        $FromDate = $request->input('DOB');
        if ($FromDate != null) {
            $FromArr = array_map('trim', explode('/', $FromDate));
            $from_month_int = array_search($FromArr[1], $month,true)+1 >= 10  ? array_search($FromArr[1], $month,true)+1
                : '0'.(array_search($FromArr[1], $month,true)+1);
            $from_day_int = $FromArr[0] >= 10  ? $FromArr[0]
                : '0'.($FromArr[0]);
            $FromDate = $FromArr[2] . '-' .  $from_month_int  . '-' . $from_day_int;
        }


        if ($data) {
            DB::table('aca_stu_details')
                ->where('StudentID', $request->input('StudentID'))
                ->update([
                'StudentID' => $request->input('StudentID'),
                'FatherName' => $request->input('FatherName'),
                'MotherName' => $request->input('MotherName'),
                'PresentAddress' => $request->input('PresentAddress'),
                'PermanetAddress' => $request->input('PermanetAddress'),
                'DOB' => $FromDate,
                'ContactNo' => $request->input('ContactNo'),
            ]);
        } else {
            DB::table('aca_stu_details')->insert([
                'StudentID' => $request->input('StudentID'),
                'FatherName' => $request->input('FatherName'),
                'MotherName' => $request->input('MotherName'),
                'PresentAddress' => $request->input('PresentAddress'),
                'PermanetAddress' => $request->input('PermanetAddress'),
                'DOB' => $FromDate,
                'ContactNo' => $request->input('ContactNo'),
            ]);
        }

    }

    public function UserLatLongSave(Request $request)
    {
        $studentID = $request->input('student_id');
        $latitude = $request->input('latitude');
        $longitude = $request->input('longitude');

        $value=DB::table('sec_user_latlong')->where('StudentID', $studentID)->get();

        if($value->count() == 0){
            DB::table('sec_user_latlong')->insert([
                'StudentID' => $studentID,
                'Lat' => $latitude,
                'Long' => $longitude,
            ]);
            return 1;
        }else{
            return 0;
        }
    }

    public function GetAssignment(Request $request)
    {
        $StudentID = $request->input('student_id');

        $sql="SELECT aca_assignment.*, aca_program.Name ProgramName, 
          aca_batch.Name BatchName
          FROM aca_assignment
          INNER JOIN aca_batch_running_semester ON aca_batch_running_semester.BatchID=aca_assignment.BatchID AND 
          aca_batch_running_semester.SemesterID=aca_assignment.SemesterID
          INNER JOIN aca_stu_basic ON aca_stu_basic.BatchID=aca_batch_running_semester.BatchID
            INNER JOIN aca_program on aca_program.ID = aca_assignment.ProgramID
            INNER JOIN aca_batch on aca_batch.ID = aca_assignment.BatchID
          WHERE aca_stu_basic.ID=".$StudentID." and aca_assignment.SubmitDate>='".date('Y-m-d H:i:s')."'
          ORDER BY aca_assignment.CourseID ";
        return $assignment = DB::select($sql);
    }

    public function GetProfileInfo(Request $request)
    {
        $StudentID = $request->input('student_id');

        $sql="SELECT aca_stu_basic.Name, aca_stu_basic.RegistrationNo, aca_stu_basic.ClassRoll, aca_stu_basic.ExamRoll, 
        aca_stu_basic.Email, aca_stu_basic.DepartmentID, aca_stu_basic.ProgramID, aca_stu_basic.SessionID, aca_stu_basic.BatchID,
        aca_department.Name  DepartmentName, aca_program.Name ProgramName, aca_session.Name SessionName,
        aca_batch.Name BatchName
        FROM aca_stu_basic 
        INNER JOIN aca_department on aca_department.ID = aca_stu_basic.DepartmentID
        INNER JOIN aca_program on aca_program.ID = aca_stu_basic.ProgramID
        INNER JOIN aca_session on aca_session.ID = aca_stu_basic.SessionID
        INNER JOIN aca_batch on aca_batch.ID = aca_stu_basic.BatchID
        WHERE aca_stu_basic.ID = " . $StudentID;
        return DB::select($sql);
    }

    public function GetExam(Request $request)
    {
        $CourseID = $request->input('course_id');
        $StudentID = $request->input('student_id');
        $SemesterID = $request->input('semester_id');

        $sql="SELECT aca_exam.ID, aca_exam.Name, aca_exam.SemesterId, aca_semester.Name SemesterName, aca_exam.CourseId, 
            aca_course.Name CourseName, aca_exam.QuestionType, aca_exam.SecurityType, DATE_FORMAT(aca_exam.ExamDateTime, '%d-%m-%Y') ExamDateTime, aca_exam.Marks, aca_exam.Duration, aca_exam.IsApprove 
				   FROM aca_exam INNER JOIN aca_course on aca_course.ID=aca_exam.CourseID INNER JOIN
				   aca_semester ON aca_semester.ID=aca_exam.SemesterID INNER JOIN
				   aca_exam_allow_student on aca_exam.ID=aca_exam_allow_student.ExamID INNER JOIN
				   aca_batch_running_semester ON aca_batch_running_semester.BatchID=aca_exam.BatchID AND aca_batch_running_semester.SemesterID=aca_exam.SemesterID
				   WHERE aca_exam.IsApprove=1 and aca_exam_allow_student.Status=1 and aca_exam_allow_student.StudentID='".$StudentID."' 
				   AND ADDTIME(ExamDateTime, Duration)>'".date('Y-m-d H:i:s')."' 
				   AND aca_exam.CourseID IN (SELECT ID FROM aca_course
                    WHERE SemesterID=aca_batch_running_semester.SemesterID AND IsOptional=0
                    UNION ALL 
                    SELECT CourseID FROM aca_student_optional_course
                    WHERE SemesterID=aca_batch_running_semester.SemesterID AND BatchID=aca_batch_running_semester.BatchID AND StudentID=".$StudentID.")
				   
				   ORDER BY aca_exam.ExamDateTime ";
        return DB::select($sql);
    }

    public function GetAttendance(Request $request)
    {
//        return $request;
        $FromDate = $request->input('fromDate');
        $ToDate = $request->input('toDate');
        $CourseID = $request->input('course_id');
        $StudentID = $request->input('student_id');
        $SemesterID = $request->input('semester_id');
        $month = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

        if ($FromDate != null) {
            $FromArr = array_map('trim', explode('/', $FromDate));
            $from_month_int = array_search($FromArr[1], $month,true)+1 >= 10  ? array_search($FromArr[1], $month,true)+1
                : '0'.(array_search($FromArr[1], $month,true)+1);
            $from_day_int = $FromArr[0] >= 10  ? $FromArr[0]
                : '0'.($FromArr[0]);
            $FromDate = $FromArr[2] . '-' .  $from_month_int  . '-' . $from_day_int;
        }
        if ($ToDate != null) {
            $ToArr = array_map('trim', explode('/', $ToDate));
            $to_month_int = array_search($ToArr[1], $month,true)+1 >= 10  ? array_search($ToArr[1], $month,true)+1
                : '0'.(array_search($ToArr[1], $month,true)+1);
            $to_day_int = $ToArr[0] >= 10  ? $ToArr[0]
                : '0'.($ToArr[0]);
            $ToDate = $ToArr[2] . '-' .  $to_month_int  . '-' . $to_day_int;
        }


        $where = "";
        if ($CourseID != "") {
            $where .= " and CourseID = $CourseID ";
        }
        if ($StudentID != "") {
            $where .= " and StudentID = $StudentID ";
        }
        if ($SemesterID != "") {
            $where .= " and SemesterID = $SemesterID ";
        }

        if ($FromDate != null && $ToDate != null) {
            $where .= " AND AttDay BETWEEN '$FromDate' AND '$ToDate' ";
        }

        $sql = "SELECT aca_student_attendance.*
		      FROM aca_student_attendance
			  WHERE 1=1  $where 
			  ORDER BY AttDay";

        return DB::select($sql);
    }
    public function UploadFile(Request $request)
    {
        $file = $request->file('file');
        $destinationPath = '/../xampp/htdocs/gui/asssignmentsubmit';
//        $destinationPath = '/uploads';

        $assignment = DB::table('aca_assignment')
            ->select('SemesterID', 'CourseID')
            ->where('id', $request->input('assignment_id'))->first();

        $assignment_submit = DB::table('aca_assignment_submit')
            ->select('ID')
            ->where('AssignmentID', $request->input('assignment_id'))
            ->where('StudentID', $request->input('student_id'))
            ->first();

        if ($assignment_submit) {
            return response()->json([
                'label' => 'Validation',
                'error' => 'Assignment Already Submitted',
            ], 404);
        } else {
            $file_name = time() . '_' . $file->getClientOriginalName();

            DB::table('aca_assignment_submit')->insert([
                'SemesterID' => $assignment->SemesterID,
                'CourseID' => $assignment->CourseID,
                'AssignmentID' => $request->input('assignment_id'),
                'StudentID' => $request->input('student_id'),
                'SubmitDate' => date('Y-m-d'),
                'FileName' => $file_name
            ]);

            $file->move($destinationPath, $file_name);
            return response()->json(['success' => 'success'], 200);
        }

    }

    public function ClassListByBatchPost($student_id, Request $request) {
        $day = $request->input('day');
        $sql="SELECT DISTINCT aca_class_schedule_master.ProgramID, aca_program.Name ProgramName,aca_semester.Name SemesterName, aca_batch.Name BatchName, aca_class_schedule_master.SemesterID, aca_class_schedule_details.DayID, aca_class_schedule_details.TimeID, aca_class_schedule_master.CourseID,
        aca_class_schedule_details.RoomID, aca_time_slot.Name TimeName, aca_days.Day, aca_room.Name RoomName, aca_room.ClassCapacity, aca_course.Code, aca_course.Name CourseName, aca_batch.ID BatchID
        FROM aca_class_schedule_master
        INNER  JOIN aca_class_schedule_details on aca_class_schedule_master.ID=aca_class_schedule_details.ClassScheduID
        INNER JOIN aca_time_slot ON aca_time_slot.ID=aca_class_schedule_details.TimeID
        INNER JOIN aca_days ON aca_days.ID=aca_class_schedule_details.DayID
        INNER JOIN aca_room ON aca_room.ID=aca_class_schedule_details.RoomID
        INNER JOIN aca_course ON aca_course.ID=aca_class_schedule_master.CourseID
        INNER JOIN aca_program ON aca_program.ID=aca_class_schedule_master.ProgramID
        INNER JOIN aca_semester ON aca_semester.ID=aca_class_schedule_master.SemesterID
        INNER JOIN aca_batch ON aca_batch.ID=aca_class_schedule_master.BatchID
        INNER JOIN aca_batch_running_semester ON aca_batch_running_semester.BatchID=aca_class_schedule_master.BatchID AND aca_batch_running_semester.SemesterID=aca_class_schedule_master.SemesterID
        INNER JOIN aca_stu_basic ON aca_stu_basic.BatchID=aca_batch_running_semester.BatchID
        WHERE aca_stu_basic.ID=$student_id and aca_class_schedule_details.DayID = $day
        AND aca_class_schedule_master.CourseID IN (SELECT ID FROM aca_course
                                                                                                WHERE SemesterID=aca_batch_running_semester.SemesterID AND IsOptional=0
                                                                                                UNION ALL 
                                                                                                SELECT CourseID FROM `aca_student_optional_course`
                                                                                                WHERE SemesterID=aca_batch_running_semester.SemesterID AND BatchID=aca_batch_running_semester.BatchID AND StudentID=1 )
        ORDER BY aca_class_schedule_details.DayID,aca_time_slot.StartTime, aca_class_schedule_master.CourseID";

        return DB::select($sql);
    }

    public function ClassListByBatch($student_id) {
        $sql="SELECT DISTINCT aca_class_schedule_master.ProgramID, aca_program.Name ProgramName,aca_semester.Name SemesterName, aca_batch.Name BatchName, aca_class_schedule_master.SemesterID, aca_class_schedule_details.DayID, aca_class_schedule_details.TimeID, aca_class_schedule_master.CourseID,
        aca_class_schedule_details.RoomID, aca_time_slot.Name TimeName, aca_days.Day, aca_room.Name RoomName, aca_room.ClassCapacity, aca_course.Code, aca_course.Name CourseName, aca_batch.ID BatchID
        FROM aca_class_schedule_master
        INNER  JOIN aca_class_schedule_details on aca_class_schedule_master.ID=aca_class_schedule_details.ClassScheduID
        INNER JOIN aca_time_slot ON aca_time_slot.ID=aca_class_schedule_details.TimeID
        INNER JOIN aca_days ON aca_days.ID=aca_class_schedule_details.DayID
        INNER JOIN aca_room ON aca_room.ID=aca_class_schedule_details.RoomID
        INNER JOIN aca_course ON aca_course.ID=aca_class_schedule_master.CourseID
        INNER JOIN aca_program ON aca_program.ID=aca_class_schedule_master.ProgramID
        INNER JOIN aca_semester ON aca_semester.ID=aca_class_schedule_master.SemesterID
        INNER JOIN aca_batch ON aca_batch.ID=aca_class_schedule_master.BatchID
        INNER JOIN aca_batch_running_semester ON aca_batch_running_semester.BatchID=aca_class_schedule_master.BatchID AND aca_batch_running_semester.SemesterID=aca_class_schedule_master.SemesterID
        INNER JOIN aca_stu_basic ON aca_stu_basic.BatchID=aca_batch_running_semester.BatchID
        WHERE aca_stu_basic.ID=$student_id
        AND aca_class_schedule_master.CourseID IN (SELECT ID FROM aca_course
                                                                                                WHERE SemesterID=aca_batch_running_semester.SemesterID AND IsOptional=0
                                                                                                UNION ALL 
                                                                                                SELECT CourseID FROM `aca_student_optional_course`
                                                                                                WHERE SemesterID=aca_batch_running_semester.SemesterID AND BatchID=aca_batch_running_semester.BatchID AND StudentID=1 )
        ORDER BY aca_class_schedule_details.DayID,aca_time_slot.StartTime, aca_class_schedule_master.CourseID";

        return DB::select($sql);
    }
    public function CourserMaterialByCourseID($CourseID)
    {

        $sql="SELECT aca_course_material.Name, aca_course_material.FileName FROM aca_course_material
			  WHERE CourseID=$CourseID	";

        $data = DB::select($sql);
        $files = [];
        foreach ($data as $key => $value) {
            $files[$key]['FileType'] = pathinfo($value->FileName, PATHINFO_EXTENSION);
            $files[$key]['FileName'] = $value->FileName;
            $files[$key]['Name'] = $value->Name;
        }

        return $files;

    }
    public function CourserByClassRoll($class_roll)
    {
        $sql="SELECT aca_course.Id as value, aca_course.Code, aca_course.Name as label FROM aca_stu_basic INNER JOIN
                  aca_batch_running_semester ON aca_batch_running_semester.BatchID=aca_stu_basic.BatchID INNER JOIN
                  aca_course on aca_course.SemesterID=aca_batch_running_semester.SemesterID
                  WHERE ClassRoll='".$class_roll."'
                  ORDER BY aca_course.Code";

      return  $class = DB::select($sql);

    }
    public function dashboardCount($student_id)
    {
//        $date = date('Y-m-d', strtotime('-2 day', strtotime(date('Y-m-d'))));
        $date = date('Y-m-d');

        $sql="SELECT aca_class_schedule_master.CourseID
      FROM aca_class_schedule_master
      INNER  JOIN aca_class_schedule_details on aca_class_schedule_master.ID=aca_class_schedule_details.ClassScheduID
      INNER JOIN aca_batch_running_semester ON aca_batch_running_semester.BatchID=aca_class_schedule_master.BatchID 
      AND aca_batch_running_semester.SemesterID=aca_class_schedule_master.SemesterID
      INNER JOIN aca_stu_basic ON aca_stu_basic.BatchID=aca_batch_running_semester.BatchID
      WHERE aca_stu_basic.ID=".$student_id." and aca_class_schedule_details.Date='".$date."'
      ORDER BY aca_class_schedule_master.CourseID";

        $class = DB::select($sql);



        $sql="SELECT aca_assignment.CourseID
      FROM aca_assignment
      INNER JOIN aca_batch_running_semester ON aca_batch_running_semester.BatchID=aca_assignment.BatchID AND 
      aca_batch_running_semester.SemesterID=aca_assignment.SemesterID
      INNER JOIN aca_stu_basic ON aca_stu_basic.BatchID=aca_batch_running_semester.BatchID
      WHERE aca_stu_basic.ID=".$student_id." and aca_assignment.SubmitDate>='".$date."'
      ORDER BY aca_assignment.CourseID ";
       $assignment = DB::select($sql);

        $sql="SELECT aca_exam.ID, aca_exam.Name, aca_exam.SemesterId, aca_exam.CourseId, aca_course.Name CourseName, 
            aca_exam.QuestionType, aca_exam.SecurityType, aca_exam.ExamDateTime, aca_exam.Marks, aca_exam.Duration, aca_exam.IsApprove 
           FROM aca_exam inner join aca_course on aca_course.ID=aca_exam.CourseID inner join 
           aca_exam_allow_student on aca_exam.ID=aca_exam_allow_student.ExamID
           WHERE aca_exam.IsApprove=1 and aca_exam_allow_student.Status=1 
           and aca_exam_allow_student.StudentID='".$student_id."' 
           AND aca_exam.ExamDateTime>'".$date."' ORDER BY aca_exam.ExamDateTime ";
        $exam = DB::select($sql);
        return [
            'class' => count($class),
            'assignment' => count($assignment),
            'exam' => count($exam),
//            'class' => 5,
//            'assignment' => 8,
//            'exam' => count($exam),
        ];
    }

    public function login(Request $request)
    {
        $username = $request->input('username');
        $password = md5($request->input('password'));


        $res = DB::table('sec_user')->select('EmployeeID', 'UserType', 'IsActive', 'UserName')
            ->where('UserName', $username)
//            ->where('EmployeeID', $username)
            ->where('Password', $password)->first();

        if ($res) {

            if ($res->IsActive == 1) {
                if ($res->UserType == 'Student') {
                    $student = DB::table('aca_stu_basic')
                        ->select('ID', 'Name', 'ApplicationNo', 'RegistrationNo', 'ClassRoll', 'ExamRoll')
                        ->where('RegistrationNo', $res->EmployeeID)->first();
                    if ($student) {
                        return [
                            'StudentID' => $student->ID,
                            'StudentName' => $student->Name,
                            'ClassRoll' => $student->ClassRoll,
                            'RegistrationNo' => $student->RegistrationNo,
                            'UserName' => $res->UserName,
                            'UserType' => $res->UserType,
                            'EmployeeID' => $res->EmployeeID,
                        ];
                    } else {
                        return response()->json([
                            'label' => 'Invalid User!',
                            'error' => 'Username or password is incorrect.',
                        ], 404);
                    }

                } else {
                    $student = DB::table('hrm_employee')
                        ->select('ID', 'Name', 'EmployeeNo')
                        ->where('EmployeeNo', $res->EmployeeID)->first();

                    return [
                        'StudentID' => $student->ID,
                        'StudentName' => $student->Name,
                        'ClassRoll' => $student->EmployeeNo,
                        'RegistrationNo' => $student->EmployeeNo,
                        'UserName' => $res->UserName,
                        'UserType' => $res->UserType,
                        'EmployeeID' => $res->EmployeeID,
                    ];
                    return response()->json([
                        'label' => 'Invalid!',
                        'error' => 'Unauthorized User',
                    ], 404);
                }
            } else {
                return response()->json([
                    'label' => 'Status!',
                    'error' => 'User Not Active',
                ], 404);
            }

        } else {
            return response()->json([
                'label' => 'Invalid User!',
                'error' => 'Username or password is incorrect.',
            ], 404);
        }
    }

    public function getAuthUser()
    {
        if ($user = $this->guard()->user()) {
            return [
                'user' => DB::table('sec_user')->select('username', 'EmployeeID')
                    ->where('id', $user->sec_user_id)->get()
            ];
        } else {
            return 0;
        }
    }

    /**
     * Log the user out (Invalidate the token)
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        $this->guard()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken($this->guard()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => $this->guard()->factory()->getTTL() * 60
        ]);
    }

    /**
     * Get the guard to be used during authentication.
     *
     * @return \Illuminate\Contracts\Auth\Guard
     */
    public function guard()
    {
        return Auth::guard();
    }
}
