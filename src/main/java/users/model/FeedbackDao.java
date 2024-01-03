package users.model;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("feedbackDao")
public class FeedbackDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "sqlField_user"; 

	public int insertFeedback(FeedbackBean fb) {
		sqlSessionTemplate.insert(namespace+".insertFeedback", fb);
		return 0;
	}
	
}
