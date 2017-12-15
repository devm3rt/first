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
 * Uçuş tablosu ile ilgili işlemlerin yapıldığı class
 */
public class Flight extends Base {

    public ResultSet getFlight(int id) throws SQLException {

        statement = conn.prepareStatement(
                "SELECT"
                + " f.OBJECTID as objectId,"
                + "  sc.\"Name\" as sCityName,"
                + "   dc.\"Name\" as dCityName,"
                + "  fc.TYPENAME as classTypeName,"
                + " f.PRICE as price,"
                + " f.\"DATE\" as date"
                + "  FROM UN.FLIGHT as f"
                + "   join Un.\"City\" as sc on f.SOURCECITYID = sc.\"ObjectId\""
                + "    join Un.\"City\" as dc on f.DESTINATIONCITYID = dc.\"ObjectId\""
                + "   join un.FLIGHTCLASSTYPE as fc on f.FLIGHTCLASSTYPEID = fc.OBJECTID"
                + " WHERE f.OBJECTID = " + id
        );
        return statement.executeQuery();

    }

    public ResultSet getFlights() throws SQLException {

        statement = conn.prepareStatement(
                "SELECT"
                + " f.OBJECTID as objectId,"
                + "  sc.\"Name\" as sCityName,"
                + "   dc.\"Name\" as dCityName,"
                + "  fc.TYPENAME as classTypeName,"
                + " f.PRICE as price,"
                + "f.\"DATE\" as date"
                + "  FROM UN.FLIGHT as f"
                + "   join Un.\"City\" as sc on f.SOURCECITYID = sc.\"ObjectId\""
                + "    join Un.\"City\" as dc on f.DESTINATIONCITYID = dc.\"ObjectId\""
                + "   join un.FLIGHTCLASSTYPE as fc on f.FLIGHTCLASSTYPEID = fc.OBJECTID"
        );
        resultSet = statement.executeQuery();

        return resultSet;

    }

    public ResultSet getFlights(int sCityId, int dCityId, String d) throws SQLException {

        statement = conn.prepareStatement(
                " SELECT"
                + " f.OBJECTID as objectId,"
                + "  sc.\"Name\" as sCityName,"
                + "   dc.\"Name\" as dCityName,"
                + "  fc.TYPENAME as classTypeName,"
                + " f.PRICE as price,"
                + " f.\"DATE\" as date"
                + ", f.\"TIME\" as time "
                + "  FROM UN.FLIGHT as f"
                + "   join Un.\"City\" as sc on f.SOURCECITYID = sc.\"ObjectId\""
                + "    join Un.\"City\" as dc on f.DESTINATIONCITYID = dc.\"ObjectId\""
                + "   join un.FLIGHTCLASSTYPE as fc on f.FLIGHTCLASSTYPEID = fc.OBJECTID"
                + " where DELETED = false "
                + " AND  f.SOURCECITYID = ? AND f.DESTINATIONCITYID = ?"
                + " AND f.\"DATE\" >= ?"
        );
        statement.setInt(1, sCityId);
        statement.setInt(2, dCityId);
        statement.setString(3, d);
        resultSet = statement.executeQuery();

        return resultSet;

    }

    public void delete(int id) throws SQLException {
        statement = conn.prepareStatement(
                "UPDATE UN.FLIGHT SET \"DELETED\" = true"
                + " WHERE OBJECTID = ?"
        );
        statement.setInt(1, id);

        statement.executeUpdate();

    }

}
