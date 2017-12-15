<%-- 
    Document   : card
    Created on : 12-Dec-2017, 22:00:42
    Author     : avcial
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="myPackage.Flight"%>
<%@page import="myPackage.Card"%>
<%@page import="myPackage.Tools"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // Sepetin sessiondan çekilmesi
    Card card = (Card) session.getAttribute(Tools.sSessionCard);

    //sepet için singleton kontrolünün yapılması
    if (card == null) {
        card = new Card();
    }
    
    // Gelen istek sepete ekle isteği mi ?
    String addToCard = request.getParameter("addToCard");
    if (addToCard != null) {
        int fligtIdToAdd = Integer.parseInt(addToCard);
        card.addToFlightIdList(fligtIdToAdd);
        session.setAttribute(Tools.sSessionCard, card);
    }
    

%>
<div class="">
    <div class="row">
        <div class="col-md-12">

            <div class="panel panel-default">
                <div class="panel-heading"> Sepet </div>
                <div class="panel-body">

                    <table class='table table-bordered table-responsive card-table'>
                        <thead>
                            <tr>

                                <th>Kalkış - Varış</th>
                                <th> Sınıf </th>
                                <th> Fiyat </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%   
                                // db bağlantısı için Flight örneği alınması
                                Flight f = new Flight();
                                
                                // Sepetteki her bir uçuşId için bilgilerin db den çekilmesi
                                for (int id : card.getFligtIdList()) {
                                    ResultSet flightResult = f.getFlight(id);
                                    flightResult.next();
                            %>
                            <tr>
                                <td><%= flightResult.getString("sCityName") + "-" + flightResult.getString("dCityName")%></td>
                                <td><%=flightResult.getString("classTypeName")%></td>
                                <td><%= flightResult.getBigDecimal("price")%></td>
                            </tr>
                            <%}%>
                        <tfoot>

                            <tr>
                                <td colspan="3"><a class="btn btn-default" href='buyFlight.jsp'> Satın Alma </a></td>
                            </tr>

                        </tfoot>
                        </tbody>
                    </table>




                </div>
            </div>



        </div>


     
    </div>
</div>

<script type="text/javascript">
    //Bu javascript kodu ile Sepet sayfaya eklenmiş olsa bile
    // boş olduğunda herhangi bir şekilde gözükmeyecektir
    $(document).ready(function () {
        // sepet tablosunun içindeki <tr> elementi sayısı sıfır ise sepet panelini gizleme
        var $rows = $(".card-table tbody tr");
        if ($rows.length == 0) {
                $(".card-table").closest(".panel").addClass("hidden");
        }

    });
</script>