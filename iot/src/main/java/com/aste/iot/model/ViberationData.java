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
	
	private float temperature;
	
	private float humidity;
	
	@Column(nullable = false, updatable = false, name="Recorded_at")
	@CreationTimestamp
	private Timestamp created_date;
	   
	public long getMeasurement() {
		return measurement;
	}
	public void setMeasurement(long measurement) {
		this.measurement = measurement;
	}
	
	
	public Timestamp getCreated_date() {
		return created_date;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	 
	public float getTemperature() {
		return temperature;
	}
	public void setTemperature(float temperature) {
		this.temperature = temperature;
	}
	public float getHumidity() {
		return humidity;
	}
	public void setHumidity(float humidity) {
		this.humidity = humidity;
	}
	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}
	
	
	
}
