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

    public function GetAttendance(Request $request)
    {
//        return $request;
        $FromDate = $request->input('from_date');
        $ToDate = $request->input('to_date');
        $CourseID = $request->input('course_id');
        $StudentID = $request->input('student_id');
        $SemesterID = $request->input('semester_id');
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

        $sql = "SELECT aca_student_attendance.*
		      FROM aca_student_attendance
			  WHERE 1=1  $where 
			  ORDER BY AttDay";

        return DB::select($sql);
    }
    public function UploadFile(Request $request)
    {
        $file = $request->file('file');
        $destinationPath = 'uploads';
        $file->move($destinationPath,$file->getClientOriginalName());
        return response()->json(['success' => 'success'], 200);
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
                        ->where('ClassRoll', $res->EmployeeID)->first();

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
