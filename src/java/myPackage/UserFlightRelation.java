/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myPackage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * Kullanıcı-uçuş ilişkilerini tutan tablo ile ilgili işlemlerin yapılmasını
 * sağlayan calss
 */
public class UserFlightRelation extends Base {

    public ResultSet getRelation(int i) throws SQLException {

        statement = conn.prepareStatement("SELECT * FROM Un.\"City\""
        //        ,resultSet.TYPE_SCROLL_INSENSITIVE
        );

        resultSet = statement.executeQuery();

        return resultSet;

    }

    public ResultSet getRelations(int uId) throws SQLException {

        statement = conn.prepareStatement(
                "    SELECT "
                + "        sc.\"Name\" as sCity "
                + ",dc.\"Name\" as dCity"
                + ",fc.TYPENAME as classType"
                + ", u.FIRSTNAME as fname"
                + ", u.LASTNAME as lname"
                + ", f.\"DATE\" as fdate"
                + " ,f.\"TIME\" as time"
                + ", f.PRICE as price"
                + ", uf.CARDNUMBER as cnumber"
                + " FROM UN.USERFLIGHTRELATION as uf"
                + "    join UN.USERS as u on u.OBJECTID = uf.USERID"
                + "    join UN.FLIGHT as f on f.OBJECTID = uf.FLIGHTID"
                + "    join UN.\"City\" as sc on sc.\"ObjectId\" = f.SOURCECITYID"
                + "    join UN.\"City\" as dc on dc.\"ObjectId\" = f.DESTINATIONCITYID"
                + "    join UN.FLIGHTCLASSTYPE as fc on fc.OBJECTID = f.FLIGHTCLASSTYPEID"
                + " where USERID = ? order by uf.CREATEDATE desc "
        );

        statement.setInt(1, uId);

        resultSet = statement.executeQuery();

        return resultSet;

    }

    public void addRelation(int uId, int fId, String date, String cardnum) {

        try {
            statement = conn.prepareStatement(
                    "INSERT INTO UN.USERFLIGHTRELATION "
                    + "(USERID, FLIGHTID, CREATEDATE, CARDNUMBER)"
                    + "	VALUES (?, ?, '2017-12-13', ?)"
            );

            statement.setInt(1, uId);
            statement.setInt(2, fId);
            //statement.setInt(3, uId);
            statement.setString(3, cardnum);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.notify();
        }

    }

}
