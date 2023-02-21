//package com.aste.iot.webservices;
//
//import java.util.List;
//import java.util.Optional;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.MediaType;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.aste.iot.model.Outputs;
//import com.aste.iot.repository.OutputServices;
//import com.aste.iot.repository.OutputsRepository;
//
//@RestController
//public class WebServices {
//	public OutputServices outputServices;
//	@Autowired
//	public OutputsRepository outputsRepository;
//	
//	@GetMapping("/")
//	@ResponseBody
//	public String welcome(){
//		return "Welcome from rest controller";
//	}
//	@RequestMapping(value="/outputs", method=RequestMethod.GET,
//	produces={MediaType.APPLICATION_JSON_VALUE})
//	public List<Outputs>getAllOutputs(){
//	return(List<Outputs>)outputsRepository.findAll();
//		
//	}
//	@RequestMapping(value="/boards/{board}", method=RequestMethod.GET,
//			produces={MediaType.APPLICATION_JSON_VALUE})
//	public  List<Outputs> getBoards(@PathVariable("board") int board){
//		List<Outputs> ops = outputsRepository.findByBoard(board);
//		
//		return(ops);
//		
//	}
// 
//}
