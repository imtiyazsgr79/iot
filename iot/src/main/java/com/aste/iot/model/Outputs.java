package com.aste.iot.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table
@DynamicUpdate
public class Outputs {
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Id
	private int id;
	@Column(name = "name")
	//@JsonIgnore
	private String name;
	/*@OneToMany
	@PrimaryKeyJoinColumn(name="board")*/
	@GeneratedValue(strategy= GenerationType.IDENTITY)
     @Column(name = "board")
     //@JsonIgnore  
	private int board;

	@Column(name = "gpio")
	//@JsonProperty("GPIO")
	private int gpio;

	@Column(name = "state")
	private int state;

	public Outputs() {

	}

	public int getBoard() {
		return board;
	}

	public int getGpio() {
		return gpio;
	}

	public int getId() {
		return  id;
	}

	public String getName() {
		return name;
	}

	public int getState() {
		return state;
	}

	public void setBoard(int board) {
		this.board = board;
	}

	public void setGpio(int gpio) {
		this.gpio = gpio;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}
	public void setState(int state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "Outputs [id=" + id + ", name=" + name + ", board=" + board + ", gpio=" + gpio + ", state=" + state
				+ "]";
	}


}
