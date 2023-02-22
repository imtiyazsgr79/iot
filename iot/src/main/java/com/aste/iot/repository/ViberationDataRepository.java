package com.aste.iot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.aste.iot.model.ViberationData;

public interface ViberationDataRepository extends JpaRepository<ViberationData, Long> {
	
	@Query(value="SELECT * FROM viberation_data ORDER BY recorded_at DESC LIMIT 15", nativeQuery = true)
	List<ViberationData> getListRecords();
	
}
