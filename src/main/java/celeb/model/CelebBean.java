package celeb.model;

import org.springframework.web.multipart.MultipartFile;

public class CelebBean {
	private int cl_num;
	private String cl_name;
	private String cl_image;
	private String cl_color;
	private MultipartFile upload_cl;
	
	public int getCl_num() {
		return cl_num;
	}
	public void setCl_num(int cl_num) {
		this.cl_num = cl_num;
	}
	public String getCl_name() {
		return cl_name;
	}
	public void setCl_name(String cl_name) {
		this.cl_name = cl_name;
	}
	public String getCl_image() {
		return cl_image;
	}
	public void setCl_image(String cl_image) {
		this.cl_image = cl_image;
	}
	public String getCl_color() {
		return cl_color;
	}
	public void setCl_color(String cl_color) {
		this.cl_color = cl_color;
	}
	public CelebBean(int cl_num, String cl_name, String cl_image, String cl_color, MultipartFile upload_cl) {
		super();
		this.cl_num = cl_num;
		this.cl_name = cl_name;
		this.cl_image = cl_image;
		this.cl_color = cl_color;
		this.upload_cl = upload_cl;
	}
	public MultipartFile getUpload_cl() {
		return upload_cl;
	}
	public void setUpload_cl(MultipartFile upload_cl) {
		this.upload_cl = upload_cl;
		if(this.upload_cl != null) { // 파일을 선택했다면
			System.out.println("업로드 할 타이틀이미지:"+upload_cl.getOriginalFilename());
			this.cl_image = upload_cl.getOriginalFilename();
		}
	}
	public CelebBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
