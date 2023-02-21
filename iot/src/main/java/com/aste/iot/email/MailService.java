/*package com.aste.iot.email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	private JavaMailSender javaMailSender;
	@Autowired
	public MailService(JavaMailSender javaMailSender){
		this.javaMailSender = javaMailSender;
		
		public void sendEmail(User user)throws MailException {
			
			SimpleMailMessage mail = new SimpleMailMessage();
			mail.setTo("");
			mail.setSubject("Testing Mail Api");
			mail.setText("THIS IS TEST MAIL");
			javaMailSender.send(mail);
			
		}
	}

}
*/