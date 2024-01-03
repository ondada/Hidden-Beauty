package users.model;

public class FeedbackBean {
	private int fb_num;
	private String u_id;
	private String u_jointype;
	private String fb_content;
	private String fb_requestApi;
	
	public int getFb_num() {
		return fb_num;
	}
	public void setFb_num(int fb_num) {
		this.fb_num = fb_num;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_jointype() {
		return u_jointype;
	}
	public void setU_jointype(String u_jointype) {
		this.u_jointype = u_jointype;
	}
	public String getFb_content() {
		return fb_content;
	}
	public void setFb_content(String fb_content) {
		this.fb_content = fb_content;
	}
	public String getFb_requestApi() {
		return fb_requestApi;
	}
	public void setFb_requestApi(String fb_requestApi) {
		this.fb_requestApi = fb_requestApi;
	}

}
