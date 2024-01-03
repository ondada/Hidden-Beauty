package product.controller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import product.model.ProductBean;
import product.model.ProductDao;


@Controller
public class ProductMainController {

	@Autowired
	private ProductDao pd;
	private final String command = "/productMain.p";
	private final String viewPage = "productMain";

	@RequestMapping(command)
	public String doAction(Model model) {
		List<ProductBean> product_BLists = pd.getBestProduct();
		model.addAttribute("product_BLists", product_BLists);
		
		List<ProductBean> product_NLists = pd.getNewProduct();
		model.addAttribute("product_NLists", product_NLists);
		return viewPage;
	}
	
}