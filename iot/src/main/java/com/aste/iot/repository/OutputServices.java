package com.aste.iot.repository;


import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aste.iot.model.Outputs;
@Service
@Transactional
public class OutputServices {
	@Autowired
	private OutputsRepository rep;

	public void save(Outputs outputs){
		rep.save(outputs);
		
	}
	/*public List<Outputs> getAllOutputs(Outputs outputs){
		Collection<Outputs> = rep.v
		
		
	}*/
}
