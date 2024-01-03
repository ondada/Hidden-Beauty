package product.model;

import org.springframework.web.multipart.MultipartFile;

public class ProductBean {
	private int p_num;
	private String p_brand;
	private String p_name;
	private String p_ttlimg;
	private String p_dtlimg;
	private String p_color;
	private int p_price;
	private int p_point;
	private int p_stock;
	private int p_salevolume;
	private String p_contents;
	private MultipartFile upload_ttl;
	private MultipartFile upload_dtl;
	
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getP_brand() {
		return p_brand;
	}
	public void setP_brand(String p_brand) {
		this.p_brand = p_brand;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_ttlimg() {
		return p_ttlimg;
	}
	public void setP_ttlimg(String p_ttlimg) {
		this.p_ttlimg = p_ttlimg;
	}
	public String getP_dtlimg() {
		return p_dtlimg;
	}
	public void setP_dtlimg(String p_dtlimg) {
		this.p_dtlimg = p_dtlimg;
	}
	public String getP_color() {
		return p_color;
	}
	public void setP_color(String p_color) {
		this.p_color = p_color;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public int getP_point() {
		return p_point;
	}
	public void setP_point(int p_point) {
		this.p_point = p_point;
	}
	public int getP_stock() {
		return p_stock;
	}
	public void setP_stock(int p_stock) {
		this.p_stock = p_stock;
	}
	public int getP_salevolume() {
		return p_salevolume;
	}
	public void setP_salevolume(int p_salevolume) {
		this.p_salevolume = p_salevolume;
	}
	public String getP_contents() {
		return p_contents;
	}
	public void setP_contents(String p_contents) {
		this.p_contents = p_contents;
	}
	
	public MultipartFile getUpload_ttl() {
		return upload_ttl;
	}
	public void setUpload_ttl(MultipartFile upload_ttl) {
		System.out.println("upload_ttl.getOriginalFilename():"+upload_ttl.getOriginalFilename());
		if(!upload_ttl.getOriginalFilename().isEmpty()) { // 파일을 선택했다면
			this.upload_ttl = upload_ttl;
			System.out.println("업로드 할 타이틀이미지:"+upload_ttl.getOriginalFilename());
			this.p_ttlimg = upload_ttl.getOriginalFilename();
		} else {
			System.out.println("타이틀이미지는 수정없이 그대로 감.");
		}
	}
	public MultipartFile getUpload_dtl() {
		return upload_dtl;
	}
	public void setUpload_dtl(MultipartFile upload_dtl) {
		System.out.println("upload_dtl.getOriginalFilename():"+upload_dtl.getOriginalFilename());
		if(!upload_dtl.getOriginalFilename().isEmpty()) { // 파일을 선택했다면
			this.upload_dtl = upload_dtl;
			System.out.println("업로드 할 디테일이미지:"+upload_dtl.getOriginalFilename()+"\n");
			this.p_dtlimg = upload_dtl.getOriginalFilename();
		} else {
			System.out.println("디테일이미지는 수정없이 그대로 감.\n");
		}
	}
	
}