package com.tech.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {
	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> Categorylist = new ArrayList<>();
		try {
			String query = "Select * from categories";
			Statement stmt = con.createStatement();
			ResultSet resultSet = stmt.executeQuery(query);
			while (resultSet.next()) {
				int cid = resultSet.getInt("categoriesId");
				String name = resultSet.getString("name");
				String description = resultSet.getString("description");

				Category c = new Category(cid, name, description);
				Categorylist.add(c);
			}
		} catch (Exception e) {

		}
		return Categorylist;
	}

	// save post to database
	public boolean savePost(Post p) {
		boolean queryExecuted = false;
		try {
			String query = "insert into posts(pTitle,pContent,pCode,pPic,categoriesId,userId) values(?,?,?,?,?,?)";
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, p.getpTitle());
			stmt.setString(2, p.getpContent());
			stmt.setString(3, p.getpCode());
			stmt.setString(4, p.getpPic());
			stmt.setInt(5, p.getCategoriesId());
			stmt.setInt(6, p.getUserId());

			stmt.executeUpdate();
			queryExecuted = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return queryExecuted;
	}

	// get all the posts from DB
	public List<Post> getAllPosts() {
		List<Post> allPostsList = new ArrayList<>();
		// fetch all the posts
		try {
			String query = "select * from posts order by pid desc";
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				int pId = rs.getInt("pId");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("pDate");
				int categoriesId = rs.getInt("categoriesId");
				int userId = rs.getInt("userId");

				Post post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, categoriesId, userId);

				allPostsList.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allPostsList;
	}

	public List<Post> getPostByCategoryId(int cId) {
		List<Post> allPostsList = new ArrayList<>();
		// get all post by categoryId
		try {
			String query = "select * from posts where categoriesId=? order by pId desc";
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setInt(1, cId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				int pId = rs.getInt("pId");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("pDate");
				int userId = rs.getInt("userId");

				Post post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, cId, userId);

				allPostsList.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allPostsList;
	}

	public Post getPostByPostId(int postId) {
		Post post = null;
		// get all post by Id
		try {
			String query = "select * from posts where pId=?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, postId);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				post = new Post();
				int pId = rs.getInt("pId");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("pDate");
				int userId = rs.getInt("userId");
				int cId = rs.getInt("categoriesId");

				post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, cId, userId);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}
}
