package c_board.model;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import users.model.UsersBean;
import utility.Paging;


@Component("CBoard")
public class CBoardDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace="c_board.model.CBoardBean.";

	public List<CBoardBean> getAllBoardList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		List<CBoardBean> list = sqlSessionTemplate.selectList(namespace+"getAllBoardList",map,rowBounds);
		 
		return list;
	}
	
	public int getTotalCount(Map<String, String> map) {
		int totalCount = sqlSessionTemplate.selectOne(namespace+"getTotalCount",map);
		return totalCount;
	}

	public CBoardBean selectContent(int c_num) {
		CBoardBean bb = sqlSessionTemplate.selectOne(namespace+"selectContent",c_num);
		return bb;
	}

	public void deleteBoard(int c_num) {

		sqlSessionTemplate.delete(namespace+"deleteBoard",c_num);
		
	}

	public void writeBoard(CBoardBean bb) {

		sqlSessionTemplate.insert(namespace+"writeBoard",bb);
		
	}

	public int selectPw(CBoardBean bb) {

		int check = sqlSessionTemplate.selectOne(namespace+"selectPw",bb);
		
		return check;
	}

	public void updateBoard(CBoardBean bb) {

		sqlSessionTemplate.update(namespace+"updateBoard",bb);
		
	}
	
	public void updateReadcount(int c_num) {

		sqlSessionTemplate.update(namespace+"updateReadcount", c_num);
		
	}

	public void replyProc(CBoardBean bb) {

		sqlSessionTemplate.update(namespace+"plusStep",bb);
		
		bb.setC_re_step(bb.getC_re_step()+1);
		bb.setC_re_level(bb.getC_re_level()+1);

		sqlSessionTemplate.insert(namespace+"insertReply",bb);
		
	}

	public List<CBoardBean> getBoardById(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		List<CBoardBean> list = sqlSessionTemplate.selectList(namespace+"getBoardById", map, rowBounds);
		return list;
	}
	
	public int getTotalCountById(Map<String, String> map) {
		int totalCount = sqlSessionTemplate.selectOne(namespace+"getTotalCountById",map);
		return totalCount;
	}

	public void deleteChkBoard(int[] checks) {
		for(int i=0; i<checks.length; i++) {
			int c_num = checks[i];
			sqlSessionTemplate.delete(namespace+"deleteBoard",c_num);
		}
	}

	public UsersBean getUserByCWriter(String c_writer) {
		UsersBean ub = sqlSessionTemplate.selectOne(namespace+"getUserByCWriter", c_writer);
		return ub;
	}

	public void updateReport(int c_num) {
		System.out.println("dao c_num : " + c_num);
		sqlSessionTemplate.update(namespace+"updateReport", c_num);
	}

	public int getTotalCountOfMainPost(String c_writer) {
		return sqlSessionTemplate.selectOne(namespace+"getTotalCountOfMainPost", c_writer);
	}

	public List<CBoardBean> getBoardOfMainPost(Paging pageInfo, String c_writer) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		return sqlSessionTemplate.selectList(namespace+"getBoardOfMainPost", c_writer, rowBounds);
	}

	public int getTotalCountOfComment(String c_writer) {
		return sqlSessionTemplate.selectOne(namespace+"getTotalCountOfComment", c_writer);
	}

	public List<CBoardBean> getBoardOfComment(Paging pageInfo, String c_writer) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		return sqlSessionTemplate.selectList(namespace+"getBoardOfComment", c_writer, rowBounds);
	}

	public String getMainPost(int c_ref) {
		return sqlSessionTemplate.selectOne(namespace+"getMainPost", c_ref);
	}

	
}
