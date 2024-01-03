package mall.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import product.model.ProductBean;
import users.model.UsersBean;
import utility.Paging;

@Component("orderDao")
public class OrderDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "sqlField_mall";
	
	public void insertTemp(Map<String, String> map) {
		sqlSessionTemplate.insert(namespace+".insertTemp", map); 
	} 

	public TempCart selectTemp(String cart_num) {
		System.out.println("cart_num : " + cart_num);
		TempCart tc = sqlSessionTemplate.selectOne(namespace+".selectTemp", cart_num);
		return tc;
	}

	public ProductBean selectProd(String p_num) {
		
		ProductBean pb = sqlSessionTemplate.selectOne(namespace+".selectProd", p_num);
		
		return pb;
	}

	public UsersBean selectUser(String u_id) {
		
		UsersBean ub = sqlSessionTemplate.selectOne(namespace+".selectUser", u_id);
		
		return ub;
	}

	public void deleteTemp(String cart_num) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cart_num", cart_num);
		sqlSessionTemplate.delete(namespace+".deleteTemp", map);
	}

	public void insertOrderInfo(OrderBean ob) {
		sqlSessionTemplate.insert(namespace+".insertOrderInfo", ob);
	}

	public void insertOrderProd(TempCart tc, int maxO_num) {
		
		Map<String, String> map =  new HashMap<String, String>();
		
		map.put("o_num", Integer.toString(maxO_num));
		map.put("p_num", Integer.toString(tc.getP_num()));
		map.put("cart_qty", Integer.toString(tc.getCart_qty()));		
		
		sqlSessionTemplate.insert(namespace+".insertOrderProd", map);
		
	}

	public int selectMaxO_num() {
		int MaxO_num = 0;
		try {
			MaxO_num = sqlSessionTemplate.selectOne(namespace+".selectMaxO_num");
		} catch(NullPointerException e) {
			
		}
		return MaxO_num;
		
	}

	 

	public void insertCartOrderPord(CartBean cartBean, int maxO_num) {
		Map<String, String> map =  new HashMap<String, String>();
		
		map.put("o_num", Integer.toString(maxO_num));
		map.put("p_num",  cartBean.getP_num());		
		map.put("cart_qty", Integer.toString(cartBean.getCart_qty()));		
		
		sqlSessionTemplate.insert(namespace+".insertOrderProd",map);
		
	}

	public void deleteAllCart(String cart_num) {
		 
		sqlSessionTemplate.delete(namespace+".deleteAllCart",cart_num);
	}

	public void downStockPord(CartBean cartBean) {
		 
		sqlSessionTemplate.update(namespace+".downStockPord",cartBean);
	}

	public void upSalevolumePord(CartBean cartBean) {
		sqlSessionTemplate.update(namespace+".upSalevolumePord",cartBean);
	}

	public void downStockPord(TempCart tc) {
		sqlSessionTemplate.update(namespace+".downStockPord",tc);
		
	}

	public void upSalevolumePord(TempCart tc) {
		sqlSessionTemplate.update(namespace+".upSalevolumePord",tc);
		
	}

	public List<OrdersProduct> getCartInfo(int o_num) {
		List<OrdersProduct> oLists = sqlSessionTemplate.selectList(namespace+".getCartInfo", o_num);
		return oLists;
	}

	public int getPriceByPnum(int p_num) {
		int price = sqlSessionTemplate.selectOne(namespace+".getPriceByPnum", p_num);
		return price;
	}

	public OrderBean selectOrders(int o_num) {
		OrderBean ob = sqlSessionTemplate.selectOne(namespace+".selectOrders", o_num);
		
		return ob;
	}

	public  int selectPoint(String string) {
		int p_point = sqlSessionTemplate.selectOne(namespace+".selectPoint", string);
		return p_point;
	}

	public void deleteOrder(int o_num) {
		sqlSessionTemplate.delete(namespace+".deleteOrder", o_num);
		
	}

	public void deleteOrderProd(int o_num) {
		sqlSessionTemplate.delete(namespace+".deleteOrderProd", o_num);
		
	}

	public List<OrderBean> getOrdersByU_id(String u_id, Paging pageInfo) {
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<OrderBean> obList = sqlSessionTemplate.selectList(namespace+".getOrdersByU_id", u_id, rowbounds);
		return obList;
	}

	public int getOrdersCountByU_id(String u_id) {
		int count = sqlSessionTemplate.selectOne(namespace+".getOrdersCountByU_id", u_id);
		return count;
	}
	
	public List<OrdersProductBean> getAllOrdersProduct2(String o_num) {
		List<OrdersProductBean> ordProdlist = sqlSessionTemplate.selectList(namespace+".getAllOrdersProduct2", o_num);
		return ordProdlist;
	}
	
	public ProductBean selectPord2(String p_num) {
		ProductBean pb = sqlSessionTemplate.selectOne(namespace+".selectPord2", p_num);
		return pb;
	}
	
	public OrderBean getOneOrder2(String o_num) {
		OrderBean ob = sqlSessionTemplate.selectOne(namespace+".getOneOrder2", o_num);
		return ob;
	}
	 
}
