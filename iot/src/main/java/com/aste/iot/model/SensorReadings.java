package com.aste.iot.model;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table
public class SensorReadings {
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Id
	@Column(name="id")
	private long id;
	@Column(name="Temperature")
	private double value1;
	@Column(name="Pressure")
	private double value2;
	@Column(name="Humidity")
	private double value3;
	@Column(nullable = false, updatable = false, name="Created_at")
	@CreationTimestamp
	private Timestamp created_at;
	
	public SensorReadings() {
		
	}
	public double getValue1() {
		return value1;
	}
	public void setValue1(double value1) {
		this.value1 = value1;
	}
	public double getValue2() {
		return value2;
	}
	public void setValue2(double value2) {
		this.value2 = value2;
	}
	public double getValue3() {
		return value3;
	}
	public void setValue3(double value3) {
		this.value3 = value3;
	}
	
	
	

}
