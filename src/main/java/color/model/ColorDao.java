package color.model;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("colorDao")
public class ColorDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String nameSpace = "sqlField_color";
	
	public ColorDao() {}

	public ColorBean getColor(String color) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("color", color);
		ColorBean cb = sqlSessionTemplate.selectOne(nameSpace+".getColor", map);
		return cb;
	}
	
}
