package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	Connection con;

	public LikeDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insertLike(int postId, int UserId) {
		boolean queryExecuted = false;
		try {
			String query = "insert into likes(postId,userId) values(?,?)";
			PreparedStatement stmt = this.con.prepareStatement(query);

			// values set
			stmt.setInt(1, postId);
			stmt.setInt(2, UserId);

			stmt.executeUpdate();

			queryExecuted = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return queryExecuted;
	}

	public int countLikeOnPost(int postId) {
		int count = 0;
		try {
			String query = "select count(*) from likes where postId=?";
			PreparedStatement stmt = this.con.prepareStatement(query);

			stmt.setInt(1, postId);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count(*)");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	// method to display if user has liked a post / not
	public boolean isLikedByUser(int postId, int userId) {
		boolean liked = false;
		try {
			String query = "select * from likes where postId = ? and userId = ?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, postId);
			stmt.setInt(2, userId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				liked = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return liked;
	}

	// dislike the post
	public boolean deleteLike(int postId, int userId) {
		boolean queryExecuted = false;
		try {
			String query = "delete from likes where postId = ? and userId =? ";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, postId);
			stmt.setInt(2, userId);
			stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return queryExecuted;
	}
}
