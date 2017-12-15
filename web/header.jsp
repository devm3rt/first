<%-- 
    Document   : header
    Created on : 11-Dec-2017, 15:50:17
    Author     : avcial
--%>
<%@page import="myPackage.Card"%>
<%@page import="myPackage.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="myPackage.Tools"%>
<%

    boolean isAuth = false;

    if (session.getAttribute(Tools.sSessionUserLoginAttr) != null) {
        isAuth = true;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Flight Reservation</title>
        <%-- Tema için gerekli açık kaynak css ve javascript kütüphaneleri --%>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            .mrg-bottom{
                margin-bottom: 5%;
            }
            .mrg-top{
                
                margin-top: 2%;
            }
            .card-table th, .card-table td{
                font-size:  10px !important;
            } 
            .action-cell{
                width: 5%;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="row">
                <div class="col-md-12 mrg-bottom mrg-top">
                    <div class="pull-left">
                        <a class="btn btn-default" href="default.jsp"> Ana Sayfa</a>
                    </div>
                    <div class='pull-right'>
                        <%
                            //Kullanıcı giriş yapmış ise karşılama mesajı ve çıkış butonunun gösterilmesi.
                            if (isAuth) {
                                //Giriş yapmış kullanıcı bilgisinin db den çekilmesi
                                ResultSet rU = new User()
                                        .getUser(
                                                Integer.parseInt(session.getAttribute(Tools.sSessionUserLoginAttr).toString()));

                                rU.next();
                        %>
                        Hoşgeldin,
                        <a href="profile.jsp">  
                            <%= rU.getString("FIRSTNAME")%>
                            <%= rU.getString("LASTNAME")%>
                        </a> |
                        <a href="logout.jsp"> Çıkış </a>
                        <% } else
                            // Giriş yapılmadı ise "Giriş" ve "Üye ol" butonlarının gösterilmesi
                        { %>
                        <a class="btn btn-default" href="sign.jsp"><label class="">Üye Ol</label> </a>
                        <a class="btn btn-default" href="login.jsp"> Giriş Yap </a>
                        <%}%>



                    </div>


                </div>
                <div class='col-md-12'>






