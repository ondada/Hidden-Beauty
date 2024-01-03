package mall.model;

public class OrderBean {
	
	private int o_num;
	private String u_id;
	private String o_phone;
	private String o_name;
	private String o_message;
	private String o_addr;
	private String o_date;
	private String o_status;
	private int o_totalamount;
	private String pay_bank;
	
	public int getO_totalamount() {
		return o_totalamount;
	}
	public void setO_totalamount(int o_totalamount) {
		this.o_totalamount = o_totalamount;
	}
	public String getO_message() {
		return o_message;
	}
	public void setO_message(String o_message) {
		this.o_message = o_message;
	}
	public String getO_status() {
		return o_status;
	}
	public void setO_status(String o_status) {
		this.o_status = o_status;
	}
	private String pay_name;
	private String way;
	public int getO_num() {
		return o_num;
	}
	public void setO_num(int o_num) {
		this.o_num = o_num;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getO_phone() {
		return o_phone;
	}
	public void setO_phone(String o_phone) {
		this.o_phone = o_phone;
	}
	public String getO_name() {
		return o_name;
	}
	public void setO_name(String o_name) {
		this.o_name = o_name;
	}
	public String getO_addr() {
		return o_addr;
	}
	public void setO_addr(String o_addr) {
		this.o_addr = o_addr;
	}
	public String getO_date() {
		return o_date;
	}
	public void setO_date(String o_date) {
		this.o_date = o_date;
	}
	public String getPay_bank() {
		return pay_bank;
	}
	public void setPay_bank(String pay_bank) {
		this.pay_bank = pay_bank;
	}
	public String getPay_name() {
		return pay_name;
	}
	public void setPay_name(String pay_name) {
		this.pay_name = pay_name;
	}
	public String getWay() {
		return way;
	}
	public void setWay(String way) {
		this.way = way;
	}
	 
	
	
	
} 
