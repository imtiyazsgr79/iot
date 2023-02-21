package com.aste.iot.model;

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
public class ViberationData {
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Id
	private long id;
	@Column(name="measurments")
	private long measurement;
	
	private double temperature;
	
	private double humidity;
	   
	public long getMeasurement() {
		return measurement;
	}
	public void setMeasurement(long measurement) {
		this.measurement = measurement;
	}
	@Column(nullable = false, updatable = false, name="Recorded_at")
	@CreationTimestamp
	private Timestamp created_date;
	
	public Timestamp getCreated_date() {
		return created_date;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public double getTemperature() {
		return temperature;
	}
	public void setTemperature(double temperature) {
		this.temperature = temperature;
	}
	public double getHumidity() {
		return humidity;
	}
	public void setHumidity(double humidity) {
		this.humidity = humidity;
	}
	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}
	
	
	
}
