/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myPackage;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * Kullanıcı tablosu ile ilgili işlemlerin yapılmasını sağlayan class
 */
public class User extends Base{
    
    public ResultSet getUser(String un, String pw) throws SQLException {

            
            statement = conn.prepareStatement("SELECT *"
                    + " FROM UN.\"USERS\""
                    + " where username = ? AND password = ? "
            );
             statement.setString(1, un);
        statement.setString(2, pw);
            
            resultSet = statement.executeQuery();

            return resultSet;

        }
    
     public ResultSet getUser(int id) throws SQLException {

            
            statement = conn.prepareStatement("SELECT *"
                    + " FROM UN.\"USERS\""
                    + " where ObjectId = ? "
            );
             statement.setInt(1, id);
            
            resultSet = statement.executeQuery();

            return resultSet;

        }
    
    
    public int registerUser(String un, String pw, String fname, String lname) throws SQLException{
    
        statement = conn.prepareStatement(
                " INSERT INTO UN.\"USERS\" (USERNAME, PASSWORD, FIRSTNAME, LASTNAME)"
                        + " VALUES"
                        + " (?, ?, ?, ?)");
    
        statement.setString(1, un);
        statement.setString(2, pw);
        statement.setString(3, fname);
        statement.setString(4, lname);
        
        return statement.executeUpdate();
    }
    
  
    
}
