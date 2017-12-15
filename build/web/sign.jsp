<%-- 
    Document   : sign
    Created on : 12-Dec-2017, 22:14:54
    Author     : avcial
--%>

<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="header.jsp" %>


<%
    // Zaten giriş yapılmışsa anasayfaya yönlendirme
    if (isAuth) {
        response.sendRedirect("default.jsp");
        return;
    }

    // Gelen istek kayıt isteği mi
    String sign = request.getParameter("sign");
    boolean error = false;
    if (sign != null) {
        
        // Form parametrelerinin çekilmesi
        String fName = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String un = request.getParameter("un");
        String pw = request.getParameter("pw");
        // Gelen parametrelerde sorun var mı
        if (!fName.isEmpty() && !lname.isEmpty() && !un.isEmpty() && !pw.isEmpty()) {
            //sorun yoksa  db ye yeni satır yazılması
            int c = new User().registerUser(un, pw, fName, lname);
            if (c > 0) {
                response.sendRedirect("login.jsp");
            } else {
                // Yeni kullanıcı eklenemediyse uyarı
                error = true;
            }

        } else {

            // Gelen parametrelerde sorun var ise uyarı
            error = true;
        }

    }


%>
<form method="post">
    <div class="col-md-6 col-md-offset-3">

        <div class="panel panel-default">
            <div class="panel-heading">Kullanıcı Bilgileri</div>
            <div class="panel-body">
                <%
                    // Uyarı mesajı
                    if (error) { %>
                <div class="alert alert-warning">
                    Kayıt işlemi gerçekleştirilemedi. Lütfen bilgileri kontrol ediniz.
                </div>
                <%}
                %>


                <table class="table table-bordered">

                    <tbody>

                        <tr>
                            <td><%= Tools.sAd%></td><td><input class="form-control" type="text" name="fname" /></td>
                        </tr>
                        <tr>
                            <td><%= Tools.sSoyad%></td><td><input class="form-control" type="text" name="lname" /></td>
                        </tr>
                        <tr>
                            <td><%= Tools.sKullaniciAdi%></td><td><input class="form-control" type="text" name="un" /></td>
                        </tr> 
                        <tr>
                            <td><%= Tools.sSifre%></td><td><input class="form-control" type="password" name="pw" /></td>
                        </tr>
                    </tbody>
                    <tfoo>
                        <tr>
                            <td colspan="2"> <button class="btn btn-primary" type="submit" name="sign" value="sign">Üye Ol</button> </td>
                        </tr>
                    </tfoo>
                </table>

            </div>
        </div>

    </div>


</form>




<%@include file="footer.jsp" %>
