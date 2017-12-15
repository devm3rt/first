/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myPackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author avcial
 */
public abstract class Base {

    /**
     *Bu class databasedeki tablolar ile aynı ismi taşıyan calasslara
     * database bağlantılarında kullanılacak değişkenleri sağlamak için oluşturulmuştur.
     * Abstract olduğu için obje türetemez. Sadece miras olarak alınabilir.
     * Database bağlantılarında değiştirilmesi gereken bilgileri burdan yaparak bütün bağlantıları tek elden yönetebiliriz.
     */
    public Base(){
        try{
        
        conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        }
        catch(SQLException e){
        
        }
    };
    
    protected String URL = "jdbc:derby://localhost:1527/FlightDb";
    protected String USERNAME = "un";
    protected String PASSWORD = "pw";

    protected Connection conn = null;
    protected PreparedStatement statement = null;
    protected ResultSet resultSet = null;
}
