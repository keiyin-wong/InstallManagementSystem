package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import model.User;

public class UserDAO {
	JdbcTemplate template;
	
	public void setTemplate(JdbcTemplate template) {    
	    this.template = template;    
	}
	
	public User getUser(String userName, String password) {
		String qry = "SELECT * "
				+ "FROM users "
				+ "WHERE username = '" + userName + "' AND `password` = '" + password + "'";
		
		 return template.queryForObject(qry, new RowMapper<User>() {
			@Override
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				User user = new User();
				user.setUserName(rs.getString("username"));
				user.setPassword(password);
				return user;
			}});
	}
}
