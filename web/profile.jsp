<%-- 
    Document   : profile
    Created on : 13-Dec-2017, 12:53:09
    Author     : avcial
--%>


<%@page import="myPackage.UserFlightRelation"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="header.jsp" %>


<%
    // Giriş yapılmamış ise anasayfaya yönlendirme
    //buradaki isAuth değişkeni header.jsp den geliyor bu yapı kod tekrarı yapmamamk içn ideal
    // fakat her sayfada uyugulanamayabiliyor
    if (!isAuth) {
        response.sendRedirect("default.jsp");
        return;
    }

    //Giriş yapan kullanıcı bilgilerinin çekilmesi
    int uId = Integer.parseInt(session.getAttribute(Tools.sSessionUserLoginAttr).toString());
    ResultSet rU = new User()
            .getUser(uId);

    rU.next();
    // Kullanıcı üzerine kayıtlı uçuşların çekilmesi
    ResultSet uf = new UserFlightRelation().getRelations(uId);


%>
<form method="post">


    <table class="table table-bordered">
        <thead>
            <tr>
                <th colspan="6">
        <center> Satın aldığınız uçuşlar aşağıda listelenmektedir.</center>
                </th>
            </tr>
            <tr>
                <th><%=Tools.sKartNumarası%></th>
                <th><%=Tools.sKalkisYeri%></th>
                <th><%=Tools.sInisYeri%></th>
                <th><%=Tools.sSinifTipi%></th>
                <th><%=Tools.sTarih%></th>
                <th><%=Tools.sFiyat%></th>
            </tr>
        </thead>
        <tbody>
            <%
                // Dbdeki herbir uçuş için  tablonun oluşturulması
                while (uf.next()) {%>

            <tr>
                <td> <%=uf.getString("cnumber")%>   </td>
                <td> <%=uf.getString("sCity")%>   </td>
                <td> <%=uf.getString("dCity")%>   </td>
                <td> <%=uf.getString("classType")%>   </td>
                <td> <%=uf.getString("fdate")%> / <%=uf.getString("time").substring(0,5) %>  </td>
                <td> <%=uf.getString("price")%>   </td>

            </tr>




            <%}
            %>


        </tbody>
    </table>


</form>




<%@include file="footer.jsp" %>
