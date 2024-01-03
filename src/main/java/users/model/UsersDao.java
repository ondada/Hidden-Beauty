package users.model;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("UsersDao")
public class UsersDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "sqlField_user";

	public void register(UsersBean ub) {
		sqlSessionTemplate.insert(namespace+".register", ub);
	}

	public UsersBean getUserById(String u_id) {
		return sqlSessionTemplate.selectOne(namespace+".getUserById", u_id);
	}

	public void updatePassword(String u_id, String new_password) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("u_id", u_id);
		map.put("new_password", new_password);
		sqlSessionTemplate.update(namespace+".updatePassword", map);
	}

	public List<UsersBean> findId(UsersBean ub) {
		return sqlSessionTemplate.selectList(namespace+".findId", ub);
	}

	public String findPw(UsersBean ub) {
		return sqlSessionTemplate.selectOne(namespace+".findPw", ub);
	}

	public int updateUsers(UsersBean ub) {
		return sqlSessionTemplate.update(namespace+".updateUsers", ub);
	}
	
	public int updateColor(String personalColor, String u_id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("personalColor", personalColor);
		map.put("u_id", u_id);
		return sqlSessionTemplate.update(namespace+".updateColor", map);
	}

	public void deleteUsers(String u_id) {
		sqlSessionTemplate.delete(namespace+".deleteUsers", u_id);
	}

	public boolean findU_id(String u_id) {
		boolean found = false;
		int count = sqlSessionTemplate.selectOne(namespace+".findU_id", u_id);
		if(count > 0) {
			found = true;
		}
		return found;
	}

	public int updateReport(String u_id) {
		return sqlSessionTemplate.update(namespace+".updateReport", u_id);
	}

	public void insertRestore(RestoreBean rb) {
		sqlSessionTemplate.insert(namespace+".insertRestore", rb);
	}


	
}
