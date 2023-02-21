package com.aste.iot.repository;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aste.iot.model.Outputs;

public interface OutputsRepository extends JpaRepository<Outputs, Integer> {

	

	ArrayList<Outputs> findByBoard(int board);

	

	

	

}
