package com.tech.blog.dao;

import java.sql.*;

import com.tech.blog.entities.User;

public class UserDao {
	private Connection con;

	/**
	 * @param con
	 */
	public UserDao(Connection con) {
		this.con = con;
	}

	// method to insert user to database
	public boolean saveUser(User user) {
		boolean queryExecuted = false;
		try {
			// user --> database

			String query = "insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement prestmt = this.con.prepareStatement(query);
			prestmt.setString(1, user.getName());
			prestmt.setString(2, user.getEmail());
			prestmt.setString(3, user.getPassword());
			prestmt.setString(4, user.getGender());
			prestmt.setString(5, user.getAbout());

			prestmt.executeUpdate();
			queryExecuted = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return queryExecuted;
	}

	// method to get User details - by userEmail & userpassword
	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;
		try {

			String query = "Select * from user where email =? and password =?";

			PreparedStatement prestmt = this.con.prepareStatement(query);
			prestmt.setString(1, email);
			prestmt.setString(2, password);

			ResultSet rs = prestmt.executeQuery();
			if (rs.next()) {
				user = new User();
				// take name data from DB
				String name = rs.getString("name");
				// add individual data values to user object from Result set object
				user.setName(name);
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("register_date"));
				user.setProfile(rs.getString("profile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	// update User
	public boolean updateUser(User user) {
		boolean queryExecuted = false;
		try {
			String query = "update user set name=? , email=? , password=? , gender=? , about=? , profile=? where id=?";

			PreparedStatement preStmt = con.prepareStatement(query);
			preStmt.setString(1, user.getName());
			preStmt.setString(2, user.getEmail());
			preStmt.setString(3, user.getPassword());
			preStmt.setString(4, user.getGender());
			preStmt.setString(5, user.getAbout());
			preStmt.setString(6, user.getProfile());
			preStmt.setInt(7, user.getId());

			preStmt.executeUpdate();

			queryExecuted = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return queryExecuted;
	}

	// get user by postId
	public User getUserByUserId(int userId) {
		User user = null;
		try {
			String query = "select * from user where id=?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, userId);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				user = new User();
				// take name data from DB
				String name = rs.getString("name");
				// add individual data values to user object from Result set object
				user.setName(name);
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("register_date"));
				user.setProfile(rs.getString("profile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
}
