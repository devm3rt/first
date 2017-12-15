<%-- 
    Document   : default
    Created on : 11-Dec-2017, 16:01:07
    Author     : avcial
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="myPackage.Tools"%>
<%@page import="myPackage.Card"%>
<%@page import="myPackage.Flight"%>
<%@page import="myPackage.City"%>
<%@page import="java.util.Enumeration"%>
<%@page import="jdk.nashorn.internal.ir.WhileNode"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>



<%
    // kalkış ve iniş şehri seçenekleri için db deki şehir bilgilerinin çekilmesi
    City c = new City();
    ResultSet destCityResult = c.getCities();
    ResultSet sourceCityResult = c.getCities();
    int id;

    // Gerekli parametrelerin çekilmesi
    String search = request.getParameter("search");
    String sourceCityId = request.getParameter("sourceCityId");
    String destCityId = request.getParameter("destCityId");
    String flightDate = request.getParameter("flightDate");
    String addToCard = request.getParameter("addToCard");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="header.jsp"></jsp:include>
    <form name="selectParams" method="POST">
        <div class='col-md-12'>

            <div class="row">


                <div class="col-md-3">
                <jsp:include page="card.jsp"></jsp:include>
                </div>
                <div class='col-md-4 col-md-offset-1'>
                    <table class="table table-bordered table-responsive">
                        <tbody>
                            <tr>
                                <td>Kalkış Noktası</td>
                                <td>
                                    <select name="sourceCityId" class="form-control">
                                    <% //Kalkış şehirlerinin atanması
                                        while (sourceCityResult.next()) {
                                            id = sourceCityResult.getInt("ObjectId");

                                    %>

                                    <option value='<%= id%>' 
                                            <%
                                                // Eğer istek yapıldığında önceden seçili bir şehir var ise 
                                                // seçimin yerinde kalması
                                                if (sourceCityId != null && (Integer.parseInt(sourceCityId) == id)) {%>
                                            selected='selected' 
                                            <%}%> 
                                            > 
                                        <%= sourceCityResult.getString("Name")%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>  
                        </tr>
                        <tr>
                            <td>
                                Varış Noktası
                            </td>
                            <td>
                                <select name="destCityId" class="form-control">
                                    <% while (destCityResult.next()) {
                                        
                                        // Kalkış şehri için yapılan işlemlerin benzerleri
                                            id = destCityResult.getInt("ObjectId");
                                    %>
                                    <option value='<%= id%>'
                                            <% //daha önce seçilmiş bir şehir varsa seçili olarak gösterme
                                                if (destCityId != null && (Integer.parseInt(destCityId) == id)) {%>
                                            selected='selected' 
                                            <%}%>
                                            > 
                                        <%= destCityResult.getString("Name")%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Tarih :
                            </td>
                            <td>
                                <input type="date" name="flightDate" class="form-control" 

                                       <% // Önceden seçili bir tarih var ise seçili olarak sayfaya geri dönmesi
                                           if (flightDate != null) {%>
                                       value="<%= flightDate%>"
                                       <%} else {
                                           Date date = new Date();
                                           SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                           String format = formatter.format(date);
                                       %>
                                       value="<%= format%>"

                                       <%}

                                       %>                                
                                       />
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2">
                                <button type="submit" name="search" class="btn btn-default btn-block" ><i class="glyphicon glyphicon-search"></i> Ara </button>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>


    <div class="col-md-10 col-md-offset-1">
        <%if (search != null || addToCard != null) {
                // gelen istek "Arama" ya da "Sepete Ekle" ise parametlere uygun uçuşları listeleme
                int sCityId = Integer.parseInt(sourceCityId);
                int dtCityId = Integer.parseInt(destCityId);
                ResultSet flightResult = new Flight().getFlights(sCityId, dtCityId, flightDate);
        %>

        <table class='table table-bordered'>
            <thead>
                <tr>
                    <th class="action-cell"></th>
                    <th><%= Tools.sKalkisYeri%></th>
                    <th><%= Tools.sInisYeri%></th>
                    <th>Saat</th>
                    <th>Sınıf</th>
                    <th>Fiyat</th>

                </tr>
            </thead>
            <tbody>
                <%
                    //tablo boş mu dolu mu kontrolü için isAny flag'ı
                    boolean isAny = false;
                    while (flightResult.next()) {
                         // eklenecek uçuş sepette ekli ise listede gösterilmemesi
                        int fId = flightResult.getInt("ObjectId");
                        Card card = (Card) session.getAttribute(Tools.sSessionCard);
                        
                        if (card == null) {
                            card = new Card();
                        }
                        if (card.getFligtIdList().contains(fId)) {
                            continue;
                        }
                        isAny = true;
                %>

                <tr>
                    <td>
                        <button class="btn btn-default" type="submit" name='addToCard' value='<%=fId%>'>Ekle</button>

                    </td>

                    <td><%= flightResult.getString("sCityName")%></td>
                    <td><%= flightResult.getString("dCityName")%></td>
                    <td><%= flightResult.getDate("date")%> / <%= flightResult.getTime("time").toString().substring(0, 5)%></td>
                    <td><%=flightResult.getString("classTypeName")%></td>
                    <td><%= flightResult.getBigDecimal("price")%></td>
                </tr>
                <%}
                    if (!isAny) {    %>
                <tr> 
                    <td colspan="6">
            <center>Aradığınız kriterlere uygun uçuşumuz bulunmamaktadır.</center>
            </td>
            </tr>


            <% }
            %>
            </tbody>
        </table>
        <%}
        %>         


    </div>    


  

</form>
<jsp:include page="footer.jsp"></jsp:include>