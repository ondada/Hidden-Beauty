package users.model;
import org.springframework.web.multipart.MultipartFile;


public class UsersBean {
	private String u_id;
	private String u_name;
	private String u_password;
	private String u_phone;
	private String u_address;
	private int u_point;
	private String u_pay;
	private String u_jointype;
	private String u_joindate;
	private String u_color;
	private String u_email;
	private String u_profileimg;
	private String u_intro;
	private int u_report;
	private MultipartFile upload_img;
	
	public MultipartFile getUpload_img() {
		return upload_img;
	}
	public void setUpload_img(MultipartFile upload_img) {
		if(!upload_img.getOriginalFilename().isEmpty()) { // 파일을 선택했다면 
			this.upload_img = upload_img;
			System.out.println("업로드 할 프로필이미지:"+upload_img.getOriginalFilename());
			this.u_profileimg = upload_img.getOriginalFilename();
		} else {
			System.out.println("프로필 수정 안함.");
		}
	}
	
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id; 
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_password() {
		return u_password;
	}
	public void setU_password(String u_password) {
		this.u_password = u_password;
	}
	public String getU_phone() {
		return u_phone;
	}
	public void setU_phone(String u_phone) {
		this.u_phone = u_phone;
	}
	public String getU_address() {
		return u_address;
	}
	public void setU_address(String u_address) {
		this.u_address = u_address;
	}
	public int getU_point() {
		return u_point;
	}
	public void setU_point(int u_point) {
		this.u_point = u_point;
	}
	public String getU_pay() {
		return u_pay;
	}
	public void setU_pay(String u_pay) {
		this.u_pay = u_pay;
	}
	public String getU_jointype() {
		return u_jointype;
	}
	public void setU_jointype(String u_jointype) {
		this.u_jointype = u_jointype;
	}
	public String getU_joindate() {
		return u_joindate;
	}
	public void setU_joindate(String u_joindate) {
		this.u_joindate = u_joindate;
	}
	public String getU_color() {
		return u_color;
	}
	public void setU_color(String u_color) {
		this.u_color = u_color;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getU_profileimg() {
		return u_profileimg;
	}
	public void setU_profileimg(String u_profileimg) {
		this.u_profileimg = u_profileimg;
	}
	public String getU_intro() {
		return u_intro;
	}
	public void setU_intro(String u_intro) {
		this.u_intro = u_intro;
	}
	public int getU_report() {
		return u_report;
	}
	public void setU_report(int u_report) {
		this.u_report = u_report;
	}
	
}
