package users.model;

import java.util.Date;

public class RestoreBean {
	private int rs_num;
	private String u_id;
	private String u_email;
	private String rs_content;
	private String rs_date;
	private String rs_done;
	
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getRs_content() {
		return rs_content;
	}
	public void setRs_content(String rs_content) {
		this.rs_content = rs_content;
	}
	public String getRs_date() {
		return rs_date;
	}
	public void setRs_date(String rs_date) {
		this.rs_date = rs_date;
	}
	public int getRs_num() {
		return rs_num;
	}
	public void setRs_num(int rs_num) {
		this.rs_num = rs_num;
	}
	public String getRs_done() {
		return rs_done;
	}
	public void setRs_done(String rs_done) {
		this.rs_done = rs_done;
	}
	
}
