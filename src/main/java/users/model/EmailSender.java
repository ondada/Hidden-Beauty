package users.model;

import javax.activation.FileDataSource;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import utility.Email;

@Component("EmailSender")
public class EmailSender {
	
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private ServletContext servletContext;
	
	public String sendMail(Email email) {
		try {
		    MimeMessage message = mailSender.createMimeMessage();
		    MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		    messageHelper.setTo(email.getToEmail());
		    messageHelper.setFrom("Hidden Beauty <"+email.getFromEmail()+">");
		    messageHelper.setText(email.getContent(), true);
		    messageHelper.setSubject(email.getTitle());
		    String imagePath = servletContext.getRealPath("/resources/image/fyhbLogo.png"); 
		    System.out.println(imagePath);
		    messageHelper.addInline("image", new FileDataSource(imagePath));

		    mailSender.send(message);
		} catch(Exception e){
		    return "Error";
		}
		return "Sucess";
	}	
}
