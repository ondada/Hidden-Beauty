package color.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import color.model.ColorDao;


@Controller
public class ColorListController {
	
	private final String command = "/colList.col";
	private final String viewPage = "colList";
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String doAction() {
		return viewPage;
	}

}
