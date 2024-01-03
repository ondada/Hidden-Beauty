package mall.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Component;

import product.model.ProductBean;

@Component("cartDao")
public class CartDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "sqlField_mall";
	
	public int selectCart(CartBean cb) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".selectCart", cb);

		 System.out.println(cnt+":cnt");
		return cnt;
	}

	public void insertCart(CartBean cb) {
		 
		sqlSessionTemplate.insert(namespace+".insertCart", cb);
		
	}

	public void updateCart(CartBean cb) {
		sqlSessionTemplate.update(namespace+".updateCart", cb);
	}

	public List<CartBean> selectCart2(String cart_num) {
	 
	List<CartBean> list = sqlSessionTemplate.selectList(namespace+".selectCart2", cart_num);
		 System.out.println(list.size()+": cartlist");
		
		return list;
	}

	public ProductBean selectPord(String p_num) {
		ProductBean pb = sqlSessionTemplate.selectOne(namespace+".selectPord", p_num);
		
		return pb;
	}

	public void deleteCart(String p_num) {
		 sqlSessionTemplate.delete(namespace+".deleteCart", p_num);
	}

	public void deleteChkCart(int[] checks) {
		for(int i=0; i<checks.length; i++) {
			System.out.println("checks[i] : "+checks[i]);
			sqlSessionTemplate.delete(namespace+".deleteCart", checks[i]);
		}
	}

	public void updateCartQty(CartBean cb) {
		System.out.println("updateCartQty 들어옴");
		sqlSessionTemplate.update(namespace+".updateCartQty", cb);
	}

	 

	 
}
