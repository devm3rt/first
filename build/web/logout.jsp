<% 
    // Kullan?c? bilgisini tutan session objesi s?f?rlan?p anasayfaya y�nlendirme
session.invalidate();
response.sendRedirect("default.jsp");

%>

