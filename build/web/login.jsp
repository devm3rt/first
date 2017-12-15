<%-- 
    Document   : login
    Created on : 12-Dec-2017, 20:14:08
    Author     : avcial
--%>
<%@page import="myPackage.User"%>
<%@page import="java.sql.ResultSet"%>
<%
    String logout = request.getParameter("logout");
    if (logout != null) {
        session.removeAttribute(Tools.sSessionUserLoginAttr);
        response.sendRedirect("sign.jsp");
        return;
    }

    String sign = request.getParameter("sign");
    if (sign != null) {
        response.sendRedirect("sign.jsp");
        return;
    }

    String login = request.getParameter("login");

    boolean error = false;
    if (login != null) {
        String un = request.getParameter("un");
        String pw = request.getParameter("pw");
        un = un.trim();
        pw = pw.trim();
        boolean f = !un.isEmpty();
        boolean s = !pw.isEmpty();
        if (f && s) {

            ResultSet rUSer = new User().getUser(un, pw);
            if (rUSer.next()) {
                session.setAttribute(Tools.sSessionUserLoginAttr, rUSer.getInt("ObjectId"));
            }

        } else {
            // beklenen parametrelerde hata var mı ?
            error = true;
        }
    }
%>
<%@page import="myPackage.Tools"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // giriş yapılmış mı kontorlü
    boolean isAuthenticated = false;

    if (session.getAttribute(Tools.sSessionUserLoginAttr) != null) {
        isAuthenticated = true;
    }
%>

<%@include  file="header.jsp" %>
<form method="post">
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-default">
                    <div class="panel-heading">Panel Heading</div>
                    <div class="panel-body">

                        <% // Giriş yapılmamış ise formun gösterilmesi
                            if (!isAuthenticated) {%>
                        <table class='table table-bordered'>
                            <tbody>
                                <tr><td><%= Tools.sKullaniciAdi%></td><td><input class="form-control" type="text" name='un' /> </td></tr>
                                <tr><td><%= Tools.sSifre%></td><td><input class="form-control" type="password" name='pw' /> </td></tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2">
                                        <%if (error) {
                                                // gelen parametrelerde sorun varsa uyarı mesajının gösterilmesi
                                        %>
                                        <div class="alert alert-danger"> Kullanıcı adı veya şifre hatalı. </div>   
                                        <% }
                                        %>
                                        <button class="btn btn-primary btn-block" type="submit" value="login" name='login'>Giriş</button>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>



                        <%} else {
                            int id = (Integer) session.getAttribute(Tools.sSessionUserLoginAttr);
                            ResultSet rUser = new User().getUser(id);
                            //Giriş yapmış kullanıcı bilgisi  db den geliyorsa anasayfaya yönlendirme
                            if (rUser.next()) {
                        %>

                        <jsp:forward page="default.jsp"></jsp:forward>

                        <%}
                            }%>
                    </div>
                </div>

            </div>

        </div>
    </div>


</form>
                            <%@include file="footer.jsp"  %>





