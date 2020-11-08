<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('auth/register', 'UserController@register');
Route::post('auth/login', 'UserController@login');
Route::group(['middleware' => 'jwt.auth'], function () {
    Route::get('user', 'UserController@getAuthUser');

});
Route::get('course-list', 'CourseController@courseList');
Route::get('program-list', 'CourseController@programList');
Route::get('semester-list', 'CourseController@semesterList');
Route::get('batch-list', 'CourseController@batchList');
Route::get('schedule-list', 'CourseController@ScheduleList');


