package celeb.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("celebDao")
public class CelebDao {

	private String namespace = "celeb.model.CelebBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int getTotalCount(Map<String, String> map) {
		
		int cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount",map);
		
		return cnt;
	}

	public List<CelebBean> getAllCelebList(Map<String, String> map, Paging pageInfo) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		
		List<CelebBean> lists = sqlSessionTemplate.selectList(namespace + ".getAllCelebList",map,rowBounds);
		
		return lists;
		
	}
	
	public CelebBean getSelectOne(String cl_num) {
		CelebBean cb = sqlSessionTemplate.selectOne(namespace+".getSelectOne",cl_num);
			return cb;
		}

	
}

 

	 
	
	