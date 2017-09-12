package org.springmvc.yolowa.model.vo;

import java.util.ArrayList;

public class MemberVO {
	private String id;
	private String password;
	private String name;
	private String address;
	private String phone;
	private String filePath;
	private int point;
	private FriendVO friendVO;
	private ArrayList<CategoryVO> categoryVO;
	
	public MemberVO() {
		super();
	}
	
	public MemberVO(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}

	public MemberVO(String id, String password, String name, String address, String phone, String filePath,
			ArrayList<CategoryVO> categoryVO) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.filePath = filePath;
		this.categoryVO = categoryVO;
	}
	
	public MemberVO(String id, String password, String name, String address, String phone, String filePath, int point,
			ArrayList<CategoryVO> categoryVO) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.filePath = filePath;
		this.point = point;
		this.categoryVO = categoryVO;
	}
	
	public MemberVO(String id, String password, String name, String address, String phone, String filePath, int point,
			FriendVO friendVO, ArrayList<CategoryVO> categoryVO) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.filePath = filePath;
		this.point = point;
		this.friendVO = friendVO;
		this.categoryVO = categoryVO;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getFilePath() {
		return filePath;
	}
	
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	public int getPoint() {
		return point;
	}
	
	public void setPoint(int point) {
		this.point = point;
	}
	
	public FriendVO getFriendVO() {
		return friendVO;
	}
	
	public void setFriendVO(FriendVO friendVO) {
		this.friendVO = friendVO;
	}
	
	public ArrayList<CategoryVO> getCategoryVO() {
		return categoryVO;
	}
	
	public void setCategoryVO(ArrayList<CategoryVO> categoryVO) {
		this.categoryVO = categoryVO;
	}
	
	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", password=" + password + ", name=" + name + ", address=" + address + ", phone="
				+ phone + ", filePath=" + filePath + ", point=" + point + ", friendVO=" + friendVO + ", categoryVO="
				+ categoryVO + "]";
	}
	
}
