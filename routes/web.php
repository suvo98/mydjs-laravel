<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('course-list', 'UserController@courseList');
Route::get('program-list', 'UserController@programList');
Route::get('semester-list', 'UserController@semesterList');
Route::get('batch-list', 'UserController@batchList');
Route::get('schedule-list', 'UserController@ScheduleList');

Route::post('change-password', 'UserController@changePassword');

Route::get('dashboard-count/{student_id}', 'UserController@dashboardCount')->name('dashboard-count');
Route::get('courser-class-roll/{class_roll}', 'UserController@CourserByClassRoll')->name('courser-class-roll');
Route::get('material-course/{course_id}', 'UserController@CourserMaterialByCourseID')->name('material-course');
Route::get('class-list-by-batch/{student_id}', 'UserController@ClassListByBatch')->name('class-list-by-batch');
Route::post('class-list-by-batch/{student_id}', 'UserController@ClassListByBatchPost')->name('class-list-by-batch');
Route::post('user-latlong-save', 'UserController@UserLatLongSave')->name('user-latlong-save');
Route::post('save-notification-token', 'UserController@SaveNotificationToken')->name('save-notification-token');

Route::post('get-attendance/', 'UserController@GetAttendance')->name('get-attendance');
Route::post('get-exam/', 'UserController@GetExam')->name('get-exam');
Route::post('get-profile/', 'UserController@GetProfileInfo')->name('get-profile');
Route::post('get-assignment/', 'UserController@GetAssignment')->name('get-assignment');
Route::post('save-profile/', 'UserController@saveProfile')->name('save-profile');
Route::post('get-save-profile/', 'UserController@GetSaveProfile')->name('get-save-profile');

Route::get('get-notification/', 'UserController@getNotification')->name('get-notification');


Route::post('upload-file', 'UserController@UploadFile')->name('upload-file');

Route::post('login', 'UserController@login');