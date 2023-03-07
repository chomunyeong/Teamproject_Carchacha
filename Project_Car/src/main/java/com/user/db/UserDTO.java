package com.user.db;

import java.sql.Timestamp;

public class UserDTO {
	
		//UseDTO�쓽 硫ㅻ쾭蹂��닔 
		private int user_num;
		private String user_id;
		private String user_pass;
		private String user_name;
		private String user_hp;
		private String email;
		private String address;
		private int user_pt;
		private String user_birth;
		private String license_num;
		private String license_type;

		//UseDTO�쓽 getter,setter 
		public int getUser_num() {
			return user_num;
		}
		public void setUser_num(int user_num) {
			this.user_num = user_num;
		}
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getUser_pass() {
			return user_pass;
		}
		public void setUser_pass(String user_pass) {
			this.user_pass = user_pass;
		}
		public String getUser_name() {
			return user_name;
		}
		public void setUser_name(String user_name) {
			this.user_name = user_name;
		}
		public String getUser_hp() {
			return user_hp;
		}
		public void setUser_hp(String user_hp) {
			this.user_hp = user_hp;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address1) {
			this.address = address1;
		}
		public int getUser_pt() {
			return user_pt;
		}
		public void setUser_pt(int user_pt) {
			this.user_pt = user_pt;
		}
		public String getUser_birth() {
			return user_birth;
		}
		public void setUser_birth(String user_birth) {
			this.user_birth = user_birth;
		}
		public String getLicense_num() {
			return license_num;
		}
		public void setLicense_num(String license_num) {
			this.license_num = license_num;
		}
		public String getLicense_type() {
			return license_type;
		}
		public void setLicense_type(String license_type) {
			this.license_type = license_type;
		}
		@Override
		public String toString() {
			return "UserDTO [user_num=" + user_num + ", user_id=" + user_id + ", user_pass=" + user_pass
					+ ", user_name=" + user_name + ", user_hp=" + user_hp + ", email=" + email + ", address=" + address
					+ ", user_pt=" + user_pt + ", user_birth=" + user_birth + ", license_num=" + license_num
					+ ", license_type=" + license_type + "]";
		}
		
		
		
	

}
