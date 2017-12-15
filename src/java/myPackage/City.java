package myPackage;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * Şehir tablosu ile ilgili işlemleri yapmak için oluşturulan class
 */

    public class City extends Base{

        
        public ResultSet getCities() throws SQLException {

            statement = conn.prepareStatement("SELECT * FROM \"City\""
            );
            resultSet = statement.executeQuery();

            return resultSet;

        }

    }
