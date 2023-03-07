package com.car.db;

import java.sql.Timestamp;

public class CarInfoDTO {

	private String car_num;
	private String car_place;
	private int per_hour;
	private String car_type;
	private int car_year;
	private String car_model;
	private String car_brand;
	private String car_image;
	private String car_fuel;
	
	public String getCar_num() {
		return car_num;
	}
	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}
	public String getCar_place() {
		return car_place;
	}
	public void setCar_place(String car_place) {
		this.car_place = car_place;
	}
	public int getPer_hour() {
		return per_hour;
	}
	public void setPer_hour(int per_hour) {
		this.per_hour = per_hour;
	}
	public String getCar_type() {
		return car_type;
	}
	public void setCar_type(String car_type) {
		this.car_type = car_type;
	}
	public int getCar_year() {
		return car_year;
	}
	public void setCar_year(int car_year) {
		this.car_year = car_year;
	}
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public String getCar_brand() {
		return car_brand;
	}
	public void setCar_brand(String car_brand) {
		this.car_brand = car_brand;
	}
	public String getCar_image() {
		return car_image;
	}
	public void setCar_image(String car_image) {
		this.car_image = car_image;
	}
	public String getCar_fuel() {
		return car_fuel;
	}
	public void setCar_fuel(String car_fuel) {
		this.car_fuel = car_fuel;
	}

}
