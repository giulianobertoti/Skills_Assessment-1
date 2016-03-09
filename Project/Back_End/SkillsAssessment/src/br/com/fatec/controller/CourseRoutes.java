package br.com.fatec.controller;

import static spark.Spark.get; // select
import static spark.Spark.put; // update
import static spark.Spark.delete; // delete
import static spark.Spark.post; // insert

import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import br.com.fatec.model.ModelCourse;
import br.com.fatec.model.course.Course;

public class CourseRoutes {
	ModelCourse modelCourses = new ModelCourse();
	Gson gson = new Gson();
	
	public void getCourse() {
		
		post("/insertCourse", (req, res) -> {
			String courseData = req.body();
			Course course = gson.fromJson(courseData, Course.class);
			return modelCourses.insertCourse(course);
		}, JsonUtil.json());
		
		delete("/deleteCourse", (req, res) -> {
			String courseData = req.body();
			Course course = gson.fromJson(courseData, Course.class);
			return modelCourses.deleteCourse(course.getCode());
		}, JsonUtil.json());
		
		put("/updateCourse", (req, res) -> {
			String courseData = req.body();
			Course course = gson.fromJson(courseData, Course.class);
			return modelCourses.updateCourse(course);
		}, JsonUtil.json());
		
		get("/searchAllCourses", (req, res) -> {
			List<Course> listCourses = modelCourses.searchAllCourse();					
			return listCourses; 
		}, JsonUtil.json());
		
		get("/searchCourseById", (req, res) -> {
			String courseData = req.body();
			Course course = gson.fromJson(courseData, Course.class);
			return  modelCourses.searchCourseByCode(course.getCode());					 
		}, JsonUtil.json());
	}
}
