<% 
    // Kullan?c? bilgisini tutan session objesi s?f?rlan?p anasayfaya yönlendirme
session.invalidate();
response.sendRedirect("default.jsp");

%>

