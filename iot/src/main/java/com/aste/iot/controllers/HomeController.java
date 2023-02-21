package com.aste.iot.controllers;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.websocket.server.PathParam;

//import org.junit.runners.Parameterized.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity.BodyBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.aste.iot.model.Outputs;
import com.aste.iot.model.SensorReadings;
import com.aste.iot.model.SensorReadingsRepository;
import com.aste.iot.model.ViberationData;
import com.aste.iot.repository.OutputServices;
import com.aste.iot.repository.OutputsRepository;
import com.aste.iot.repository.ViberationDataRepository;
import com.sun.istack.Nullable;
import com.sun.xml.messaging.saaj.packaging.mime.MessagingException;
@Controller
public class HomeController {
	@Autowired
	public OutputServices outputService;
	@Autowired
	public OutputsRepository repo;
	
	@Autowired
	public SensorReadingsRepository srp;
	
	@Autowired
	public ViberationDataRepository vdr;
	
	@RequestMapping(value="/",method=RequestMethod.GET)
	
	public ModelAndView home(){
		ModelAndView mav = new ModelAndView("welcome");
		int id = 0;
		ArrayList<Outputs> output = (ArrayList<Outputs>) repo.findAll();
		mav.addObject("outputs", output);
		return mav;
		
				
	}
	@RequestMapping(value="/addoutput", method=RequestMethod.GET)
	public String showform(ModelMap model){
		model.addAttribute("outputs", new Outputs());
		return"createoutput";
	}
	
	
	
	@PostMapping(path="/addoutput")
	public String saveOutput(Outputs output ){
		
		repo.save(output);
		return "redirect:/iot";
		
	
	}
	
	@DeleteMapping(path="/delete/{id}")
	public String deleteOutput(@PathVariable("id") int id ){
		Outputs o = repo.getOne(id);
		repo.delete(o);
		return "deleted";
		
	
	}
	@GetMapping(path="/update/{id}/{state}")
	public @ResponseBody String updateOutput(@PathVariable("id") int id , @PathVariable("state") int state) {
		//System.out.println(id);
		//System.out.println(state);
		Outputs o = repo.getOne(id);
		//System.out.println(o);
		o.setState(state);
		repo.save(o);
		//return "redirect:/iot";
		return "OK";
	
	}
	
	@GetMapping(path="getboards/{board}")
	@ResponseBody
	public ResponseEntity<?> getBoards(@PathVariable("board") int board){
		List<Outputs> ops =  repo.findByBoard(board);
		Map<String,String> map = new HashMap<>();
		for (Outputs outputs : ops) {
			map.put(String.valueOf(outputs.getGpio()),String.valueOf(outputs.getState()));
		}
		return ResponseEntity.ok(map);
		
				
	}
/*	@GetMapping( value="/allOutputs")
	public ResponseEntity<?>  allOutputs(){
		List<Outputs> o = repo.findAll();
		
		for(Outputs ot:o){
			System.out.println(ot);
		}
		
		return ResponseEntity.ok(o);
		
	}
	*/
	//Just for making the service which consumes json
/*	@PostMapping(value="/getReadings",consumes={MediaType.APPLICATION_JSON_UTF8_VALUE},produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public String getSensorReadings(@RequestBody SensorReadings sor){
		SensorReadings rd = new SensorReadings();
		rd.setValue1(sor.getValue1());
		rd.setValue2(sor.getValue2());
		rd.setValue3(sor.getValue3());
		
		
		System.out.println("Value1 : "+rd.getValue1()+",Value2 : "+rd.getValue2()+",Value3 : "+rd.getValue3());
		return"welcome";
	  	
	}*/
	
	
	
		
/*	@PostMapping(value="/sendMail",consumes={MediaType.APPLICATION_JSON_UTF8_VALUE},produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public  String sendMail(@RequestBody SensorReadings sor) throws MessagingException, IOException, javax.mail.MessagingException{
		SensorReadings rd = new SensorReadings();
		rd.setValue1(sor.getValue1());
		rd.setValue2(sor.getValue2());
		rd.setValue3(sor.getValue3());
		System.out.println("Value1 : "+rd.getValue1()+",Value2 : "+rd.getValue2()+",Value3 : "+rd.getValue3());
		sendmail();
		
		
		//return"Email Sent Successfully";
		return"welcome";
	}*/
	
	@PostMapping(value="/sendMail",consumes={MediaType.APPLICATION_JSON_UTF8_VALUE},produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public String sendmail(@RequestBody SensorReadings sor) throws MessagingException, IOException, javax.mail.MessagingException {
	
		SensorReadings rd = new SensorReadings();
		srp.save(rd);
		rd.setValue1(sor.getValue1());
		rd.setValue2(sor.getValue2());
		rd.setValue3(sor.getValue3());
		
		
		if(rd.getValue1()<32){
			return"noemail";
		}else{
			
			
		   Properties props = new Properties();
		   props.put("mail.smtp.auth", "true");
		   props.put("mail.smtp.starttls.enable", "true");
		   props.put("mail.smtp.host", "smtp.gmail.com");
		   props.put("mail.smtp.port", "587");
		   
		   Session session = Session.getInstance(props, new javax.mail.Authenticator() {
		      protected PasswordAuthentication getPasswordAuthentication() {
		         return new PasswordAuthentication("aste.testinfo@gmail.com","infoAste@1234");
		      }
		   });
		   Message msg = new MimeMessage(session);
		   msg.setFrom(new InternetAddress("aste.testinfo@gmail.com", false));

		   msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("mirimtiyazsgr79@gmail.com"));
		   msg.setSubject("DHT22");
		   msg.setContent("Temperature : "+rd.getValue1()+"°C" +", Humidity : "+rd.getValue2()+"%"+ ", Pressure : "+rd.getValue3()+"hPa","text/html");
		   msg.setSentDate(new Date());

		  /* MimeBodyPart messageBodyPart = new MimeBodyPart();
		   messageBodyPart.setContent("Tutorials point email", "text/html; charset=UTF-8");

		   Multipart multipart = new MimeMultipart();
		   multipart.addBodyPart(messageBodyPart);
		   MimeBodyPart attachPart = new MimeBodyPart();

		   attachPart.attachFile("");
		   multipart.addBodyPart(attachPart);
		   msg.setContent(multipart);*/
		   
		   Transport.send(msg);
			   return"emailsent";
		}
		}
	
	
	
	//URL ENCODED
	@PostMapping(value="/sendMail",consumes=MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String sendmails(@RequestParam Map<String, String> body) throws MessagingException, IOException, javax.mail.MessagingException {
	
		SensorReadings rd = new SensorReadings();
		
		rd.setValue1(Double.valueOf(body.get("value1")));
		rd.setValue2(Double.valueOf(body.get("value2")));
		rd.setValue3(Double.valueOf(body.get("value3")));
		srp.save(rd);
		/*if(rd.getValue1()<32){
			return"noemail";
		}else{
			
			
		   Properties props = new Properties();
		   props.put("mail.transport.protocol", "smtp");
		   props.put("mail.smtp.auth", "true");
		   props.put("mail.smtp.starttls.enable", "true");
		   props.put("mail.smtp.host", "smtp.gmail.com");
		   props.put("mail.smtp.port", "587");
		   
		   Session session = Session.getInstance(props, new javax.mail.Authenticator() {
		      protected PasswordAuthentication getPasswordAuthentication() {
		         return new PasswordAuthentication("aste.testinfo@gmail.com","infoAste@1234");
		      }
		   });
		   Message msg = new MimeMessage(session);
		   msg.setFrom(new InternetAddress("aste.testinfo@gmail.com", true));

		   msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("mirimtiyazsgr79@gmail.com"));
		   msg.setSubject("DHT22");
		   msg.setContent("Temperature : "+rd.getValue1()+"°C"+ ", Humidity : "+rd.getValue2()+"%"+ ", Pressure : "+rd.getValue3()+"hPa","text/html");
		   msg.setSentDate(new Date());

		   MimeBodyPart messageBodyPart = new MimeBodyPart();
		   messageBodyPart.setContent("Tutorials point email", "text/html; charset=UTF-8");

		   Multipart multipart = new MimeMultipart();
		   multipart.addBodyPart(messageBodyPart);
		   MimeBodyPart attachPart = new MimeBodyPart();

		   attachPart.attachFile("");
		   multipart.addBodyPart(attachPart);
		   msg.setContent(multipart);
		   Transport.send(msg);*/
			   return "emailsent";
		}
		
		//}
	
	
	
	

	/*@PostMapping(value="/sendMail",consumes={"MediaType.APPLICATION_JSON_UTF_VALUE"},produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	public String sendmail(@RequestBody SensorReadings sor) throws MessagingException, IOException, javax.mail.MessagingException {
	
		SensorReadings rd = new SensorReadings();
		rd.setValue1(sor.getValue1());
		rd.setValue2(sor.getValue2());
		rd.setValue3(sor.getValue3());
		if(rd.getValue1()<32){
			return"noemail";
		}else{
			
			
		   Properties props = new Properties();
		   props.put("mail.smtp.auth", "true");
		   props.put("mail.smtp.starttls.enable", "true");
		   props.put("mail.smtp.host", "http://mail.stie.com.sg");
		   props.put("mail.smtp.port", "587");
		   
		   Session session = Session.getInstance(props, new javax.mail.Authenticator() {
		      protected PasswordAuthentication getPasswordAuthentication() {
		         return new PasswordAuthentication("info@stie.com.sg.com", "I5PaS3123457!(");
		      }
		   });
		   Message msg = new MimeMessage(session);
		   msg.setFrom(new InternetAddress("info@stie.com.sg.com", false));

		   msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("mirimtiyazsgr79@gmail.com,mirimtiyaz_sgr@rediff.com"));
		   msg.setSubject("DHT22");
		   msg.setContent("Temperature : "+rd.getValue1()+ ", Humidity : "+rd.getValue2()+ ", Pressure : "+rd.getValue3(),"text/html");
		   msg.setSentDate(new Date());

		   MimeBodyPart messageBodyPart = new MimeBodyPart();
		   messageBodyPart.setContent("Tutorials point email", "text/html; charset=UTF-8");

		   Multipart multipart = new MimeMultipart();
		   multipart.addBodyPart(messageBodyPart);
		   MimeBodyPart attachPart = new MimeBodyPart();

		   attachPart.attachFile("");
		   multipart.addBodyPart(attachPart);
		   msg.setContent(multipart);
		   Transport.send(msg);
			   return"emailsent";
		}
		}*/
	
	@GetMapping("/viberationdata")
	public ResponseEntity<?> allViberationReadings(){
		List<ViberationData> viberations = vdr.getLast();
		
		Map<String, String> map = new HashMap<>();
		
		for(ViberationData v:viberations){
			map.put(String.valueOf(v.getMeasurement()),String.valueOf(v.getCreated_date()));
			
			
		}
		
		return ResponseEntity.ok(viberations) ;	
		}
	
	/////NOT IN USE
	
	@PostMapping(value="/viberationdata",consumes=MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public ResponseEntity<?>  getViberationData(@RequestParam Map<String,String> body){
		ViberationData vd = new ViberationData();
		vd.setMeasurement(Long.valueOf(body.get("measurement")));
		
		vdr.save(vd);
		
		return new ResponseEntity<HttpStatus>(HttpStatus.OK);
		//return ResponseEntity.ok(vd);
		
	   }
	
	@PostMapping(value="/viberationdatas",consumes=MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public ResponseEntity<?>  viberationData(@RequestBody ViberationData vdrd){
		vdrd.setMeasurement(vdrd.getMeasurement());
		vdr.save(vdrd);
		return new ResponseEntity<HttpStatus>(HttpStatus.OK);
		//return ResponseEntity.ok(vd);
		
	   }
	
	///NOT IN USE
	@PostMapping(value="/viberationsensor",consumes=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?>  viberationSensor(@RequestParam Map<String,String> body){
		ViberationData vd = new ViberationData();
		vd.setMeasurement(Long.valueOf(body.get("measurement")));
		
		vdr.save(vd);
		
		return new ResponseEntity<HttpStatus>(HttpStatus.OK);
		//return ResponseEntity.ok(vd);
		
	   }
	
	///// THIS IS WORKIG URL//////
	@PostMapping(path="/sensordata",consumes=MediaType.ALL_VALUE)
	public  ResponseEntity<?> sensorData(@RequestBody ViberationData vb){
		
		vb.setMeasurement(vb.getMeasurement());
		
		System.out.println(vb.getMeasurement()+"kkkkkkkkkkkkk");
		if(vb.getMeasurement()>0){
			
			vdr.save(vb);
		}
		
		/*ResponseEntity<?> response=null;
				try{
					response=ResponseEntity.status(HttpStatus.OK).body(vb);
					
				}catch(Exception e){
					ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
				}
				return response*/;
		return new ResponseEntity<HttpStatus>(HttpStatus.OK);
	}
	
	@GetMapping(value="/showviberation")
	public String showviberation(ModelMap model){
		model.addAttribute("viberationData", new ViberationData());
		return"showviberation";
	}
	
	@ExceptionHandler
	public void exception(Exception e){
		e.printStackTrace();
	   }
	
}



	



