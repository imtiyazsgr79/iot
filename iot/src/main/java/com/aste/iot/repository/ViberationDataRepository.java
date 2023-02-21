package com.aste.iot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.aste.iot.model.ViberationData;

public interface ViberationDataRepository extends JpaRepository<ViberationData, Long> {
	@Query(value="select * from viberation_data d order by d.recorded_at DESC LIMIT 20", nativeQuery = true)
	List<ViberationData> getLast();

}
