package company.model;


public class CompanyBean {
	private int cmp_num;
	//@NotBlank(message = "회사명을 입력하세요.")
	private String cmp_name;
	private String cmp_addr;
	private int cmp_price;
	private String cmp_station;
	private String cmp_x;
	private String cmp_y;
	
	
	public int getCmp_num() {
		return cmp_num;
	}
	public void setCmp_num(int cmp_num) {
		this.cmp_num = cmp_num;
	}
	public String getCmp_name() {
		return cmp_name;
	}
	public void setCmp_name(String cmp_name) {
		this.cmp_name = cmp_name;
	}
	public String getCmp_addr() {
		return cmp_addr;
	}
	public void setCmp_addr(String cmp_addr) {
		this.cmp_addr = cmp_addr;
	}
	public int getCmp_price() {
		return cmp_price;
	}
	public void setCmp_price(int cmp_price) {
		this.cmp_price = cmp_price;
	}
	public String getCmp_station() {
		return cmp_station;
	}
	public void setCmp_station(String cmp_station) {
		this.cmp_station = cmp_station;
	}
	public String getCmp_x() {
		return cmp_x;
	}
	public void setCmp_x(String cmp_x) {
		this.cmp_x = cmp_x;
	}
	public String getCmp_y() {
		return cmp_y;
	}
	public void setCmp_y(String cmp_y) {
		this.cmp_y = cmp_y;
	}
	
	
	
	
}
