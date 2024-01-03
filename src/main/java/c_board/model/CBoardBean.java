package c_board.model;

import java.sql.Timestamp;

import org.hibernate.validator.constraints.NotEmpty;

public class CBoardBean {

	private int c_num;
	private String c_writer;
	private String c_profileimg;
	private String c_email;
	private String c_subject;
	private String c_subject_rb;
	private String c_password;
	private Timestamp c_regdate;
	private int c_readcount;
	private int c_ref;
	private int c_re_step;
	private int c_re_level;
	private String c_content;
	private String c_ip;
	private int c_report;

	public CBoardBean() {

	}
	
	public int getC_num() {
		return c_num;
	}

	public void setC_num(int c_num) {
		this.c_num = c_num;
	}

	public String getC_writer() {
		return c_writer;
	}

	public void setC_writer(String c_writer) {
		this.c_writer = c_writer;
	}
	
	public String getC_profileimg() {
		return c_profileimg;
	}
	
	public void setC_profileimg(String c_profileimg) {
		this.c_profileimg = c_profileimg;
	}

	public String getC_email() {
		return c_email;
	}

	public void setC_email(String c_email) {
		this.c_email = c_email;
	}

	public String getC_subject() {
		return c_subject;
	}

	public void setC_subject(String c_subject) {
		this.c_subject = c_subject;
	}

	public String getC_password() {
		return c_password;
	}

	public void setC_password(String c_password) {
		this.c_password = c_password;
	}

	public Timestamp getC_regdate() {
		return c_regdate;
	}

	public void setC_regdate(Timestamp c_regdate) {
		this.c_regdate = c_regdate;
	}

	public int getC_readcount() {
		return c_readcount;
	}

	public void setC_readcount(int c_readcount) {
		this.c_readcount = c_readcount;
	}

	public int getC_ref() {
		return c_ref;
	}

	public void setC_ref(int c_ref) {
		this.c_ref = c_ref;
	}

	public int getC_re_step() {
		return c_re_step;
	}

	public void setC_re_step(int c_re_step) {
		this.c_re_step = c_re_step;
	}

	public int getC_re_level() {
		return c_re_level;
	}

	public void setC_re_level(int c_re_level) {
		this.c_re_level = c_re_level;
	}

	public String getC_content() {
		return c_content;
	}

	public void setC_content(String c_content) {
		this.c_content = c_content;
	}

	public String getC_ip() {
		return c_ip;
	}

	public void setC_ip(String c_ip) {
		this.c_ip = c_ip;
	}

	public String getC_subject_rb() {
		return c_subject_rb;
	}

	public void setC_subject_rb(String c_subject_rb) {
		this.c_subject_rb = c_subject_rb;
	}

	public int getC_report() {
		return c_report;
	}

	public void setC_report(int c_report) {
		this.c_report = c_report;
	}
	
}
