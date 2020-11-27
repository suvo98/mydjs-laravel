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

Route::get('course-list', 'CourseController@courseList');
Route::get('program-list', 'CourseController@programList');
Route::get('semester-list', 'CourseController@semesterList');
Route::get('batch-list', 'CourseController@batchList');
Route::get('schedule-list', 'CourseController@ScheduleList');

Route::get('dashboard-count/{student_id}', 'UserController@dashboardCount')->name('dashboard-count');
Route::get('courser-class-roll/{class_roll}', 'UserController@CourserByClassRoll')->name('courser-class-roll');
Route::get('material-course/{course_id}', 'UserController@CourserMaterialByCourseID')->name('material-course');
Route::get('class-list-by-batch/{student_id}', 'UserController@ClassListByBatch')->name('class-list-by-batch');

Route::post('login', 'UserController@login');