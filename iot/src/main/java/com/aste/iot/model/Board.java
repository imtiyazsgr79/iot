/*package com.aste.iot.model;

import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;


@Entity
@Table
public class Board {
	@Id
	@Column(name="id")
	private int id;
	@Column(name="board")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@ManyToOne
	@PrimaryKeyJoinColumn(name="board")
	private List<Integer> board;
	private Date last_requested;
	public Board() {
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBoard() {
		return board;
	}
	public void setBoard(int board) {
		this.board = board;
	}
	public Date getLast_requested() {
		return last_requested;
	}
	@Override
	public String toString() {
		return "Board [id=" + id + ", board=" + board + ", last_requested=" + last_requested + "]";
	}
	public void setLast_requested(Date last_requested) {
		this.last_requested = last_requested;
	}

}
*/