package admin.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import mall.model.OrderBean;
import mall.model.OrdersProductBean;
import product.model.ProductBean;
import utility.Paging;

@Component("adminOrderDao")
public class AdminOrderDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "sqlField_admin";
	
	public int getTotalCountOrder(Map<String, String> map) {
		 
		int totalCount = sqlSessionTemplate.selectOne(namespace+".getTotalCountOrder", map);
		
		return totalCount;
	}
	
	public List<OrderBean> getAllOrder(Paging pageInfo, Map<String, String> map) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		List<OrderBean> list = sqlSessionTemplate.selectList(namespace+".getAllOrder", map, rowBounds);
		
		return list;
	}

	public void updateOrderStatus(String o_num) {
		
		sqlSessionTemplate.update(namespace+".updateOrderStatus", o_num);
		
	}

	public String selectOrderStatus(String o_num) {
		String status;
		
		status = sqlSessionTemplate.selectOne(namespace+".selectOrderStatus", o_num);
		
		return status;
	}

	public List<OrdersProductBean> getAllOrdersProduct(String o_num) {
		 
		List<OrdersProductBean> ordProdlist = sqlSessionTemplate.selectList(namespace+".getAllOrdersProduct", o_num);
		 
		return ordProdlist;
	}

	public OrderBean getOneOrder(String o_num) {
		
		OrderBean ob = sqlSessionTemplate.selectOne(namespace+".getOneOrder", o_num);
		 
		return ob;
	}

	public ProductBean selectPord(String p_num) {
		ProductBean pb = sqlSessionTemplate.selectOne(namespace+".selectPord", p_num);
				
		return pb;
	}

	public void updateUsersPoint(String p_point, String u_id) {
		
		Map<String,String> map = new HashMap<String, String>();
		map.put("p_point", p_point);
		map.put("u_id", u_id);	
		
		sqlSessionTemplate.update(namespace+".updateUsersPoint", map);

	}

	 
	
	
}
