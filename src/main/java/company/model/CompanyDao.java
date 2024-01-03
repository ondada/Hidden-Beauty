package company.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("myCompanyDao")
public class CompanyDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "sqlField_company";
	
	public List<CompanyBean> getAllCompany(Paging pageInfo, Map<String, String> map) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		List<CompanyBean> list = sqlSessionTemplate.selectList(namespace+".getAllCompany", map, rowBounds);
		
		return list;
	}
	
	public int getTotalCount(Map<String, String> map) {
		 
		int totalCount = sqlSessionTemplate.selectOne(namespace+".getTotalCount", map);

		return totalCount;
	}

	public CompanyBean getSelectOne(int cmp_num) {
		
		CompanyBean cb = sqlSessionTemplate.selectOne(namespace+".getSelectOne", cmp_num);
		
		return cb;
	}

}
