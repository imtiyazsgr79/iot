package com.aste.iot.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface SensorReadingsRepository extends JpaRepository<SensorReadings, Long> {
	@Query(value="select * from ViberationData v order by v.created_date DESC LIMIT 30", nativeQuery = true)
	public List<ViberationData> getLast();

}
