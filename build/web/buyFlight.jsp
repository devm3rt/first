<%-- 
    Document   : buyFlight
    Created on : 12-Dec-2017, 16:21:03
    Author     : avcial
--%>
<%@page import="myPackage.UserFlightRelation"%>
<%@page import="myPackage.User"%>
<%@page import="myPackage.Card"%>
<%@page import="java.util.Enumeration"%>
<%@page import="myPackage.Flight"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="myPackage.Tools"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="header.jsp"></jsp:include>
<%
    // Giriş yapmayan kullanıcının bu sayfayı görememesi gerektiği için sessionda authentication kontrolü
    boolean isAuthenticated = false;

    if (session.getAttribute(Tools.sSessionUserLoginAttr) != null) {
        isAuthenticated = true;
    }

    // Daha sonra kullanılmak üzere sessiondaki sepet bilgisinin tutulması
    Card card = (Card) session.getAttribute(Tools.sSessionCard);
    // session için singleton kontolünün yapılması
    if (card == null) {
        card = new Card();
    }

    // Sepetten çıkarma işlemi isteniyor mu ?
    String removeFromCard = request.getParameter("removeFromCard");

    //Sayfaya gelen istek sepetten çıkarmak içinse sepet objesinin gerekli
    //metodları ile uçuşId listeden çıkarılır, sepet yeniden sessiona atılır
    if (removeFromCard != null) {
        int fId = Integer.parseInt(removeFromCard);
        card.removeFromList(fId);
        session.setAttribute(Tools.sSessionCard, card);
    }

    // Eğer sepette satın alınacak ürün yoksa anasayfaya yönlendir.
    if (card.getFligtIdList().size() == 0) {
        response.sendRedirect("default.jsp");
        return;
    }


%>


<form method="post">


    <div class="row"> 
        <div class="col-md-6 col-md-offset-3"> 

            <div class="panel panel-default">
                <div class="panel-heading">
                    <center>
                        Satın Alma
                    </center>  
                </div>
                <div class="panel-body">
                    <div>



                        <% if (isAuthenticated) {

                                // Giriş yapılmış ise kullanıcı bilgilerinin db den çekilmesi
                                int uid = (Integer) session.getAttribute(Tools.sSessionUserLoginAttr);
                                ResultSet rUser = new User().getUser(uid);

                                if (rUser.next()) {


                        %>
                        <div>
                            <table class='table table-bordered'>
                                <thead>
                                    <tr>
                                        <th colspan="2"> Kullanıcı Bilgileri</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr><td><%= Tools.sAd%></td><td><%= rUser.getString("FIRSTNAME")%></td></tr>
                                    <tr><td><%= Tools.sSoyad%></td><td><%= rUser.getString("LASTNAME")%></td></tr>
                                    <tr><td>Kart Numarası</td> <td><input class="form-control" type="text" name="cardNum" /> </td></tr>
                                </tbody>
                            </table>
                        </div>
                        <%
                                // gelen isten satın almayı tamamla mı ?
                                String complete = request.getParameter("complete");
                                UserFlightRelation ufl = new UserFlightRelation();
                                Flight f = new Flight();
                                if (complete != null) {
                                    // satın almayı tamamlamak için 
                                    // sessiondaki her bir flightId ile 
                                    //giriş yapmış kullanıcı id si relation tablosuna yazılır.
                                    for (int fId : card.getFligtIdList()) {

                                        ufl.addRelation(
                                                uid,
                                                fId,
                                                "",
                                                request.getParameter("cardNum"));
                                        // satın alınmış uçuşlar uçuş tablosundan silinir.
                                        f.delete(fId);

                                    }
                                    // satın alma işlemi tamamlanınca sepetteki ürünler sıfırlanır
                                    session.removeAttribute(Tools.sSessionCard);
                                    // satın alınan biletleri görüntülemek üzere kullanıcı profil sayfasına yönlendirme yapılır
                                    response.sendRedirect("profile.jsp");
                                    return;
                                }

                            } %>






                        <table class='table table-bordered'>
                            <thead>
                                <tr><th colspan="5">Biletler</th></tr>
                                <tr>
                                    <td></td>
                                    <td>Kalkış - İniş</td>
                                    <td>  Tarih Saat </td>
                                    <td> Sınıf </td>
                                    <td> Ücret  </td>
                                </tr>                                   

                            </thead>
                            <tbody>
                                <%                Flight f = new Flight();
                                    for (int fid : card.getFligtIdList()) {
                                        ResultSet flightResult = f.getFlight(fid);
                                        flightResult.next();
                                %>
                                <tr>
                                    <td>
                                        <button class="btn btn-default" type="submit" name='removeFromCard' value='<%= flightResult.getInt("ObjectId")%>'><span class="glyphicon glyphicon-remove"></span></button>
                                    </td>
                                    <td>
                                        <%= flightResult.getString("sCityName") + "-" + flightResult.getString("dCityName")%>
                                    </td>
                                    <td><%= flightResult.getDate("date")%></td>
                                    <td><%=flightResult.getString("classTypeName")%></td>
                                    <td><%= flightResult.getBigDecimal("price")%></td>
                                </tr>
                                <%}%>
                            <tfoot>
                                <tr>
                                    <td colspan="5"><button class="btn btn-default btn-block" type="submit" name="complete">Satın almayı tamamla</button></td>
                                </tr>
                            </tfoot>
                            </tbody>
                        </table>

                    </div>




                    <%} else {%>

                    <div class="alert alert-info"> Giriş yapmalısınız. <a href="login.jsp"> Giriş </a> </div>
                    <%}%>




                </div>
            </div>

        </div>

    </div>





</form>
<jsp:include page="footer.jsp"></jsp:include>
