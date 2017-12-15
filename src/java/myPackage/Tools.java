/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myPackage;


/**
 *
 * Bu class proje içerisinde sıkça kullanılacak string, integer ve algoritma bilgilerinin kod tekrarı yapmadan kullanılmasını sağlamak için oluşturulmuştur.
 */
public class Tools {
    public static String sKalkisYeri = "Kalkış Yeri";
    public static String sInisYeri = "İniş Yeri";
    public static String sTarih = "Tarih Bilgisi";
    public static String sSinifTipi = " Sınif Tipi";
    public static String sFiyat = "Fiyat";    
    public static String sKullaniciAdi = "KullaniciAdi";    
    public static String sSifre = "Şifre";  
    public static String sSessionUserLoginAttr = "userLogin";  
    public static String sAd = "İsim";  
    public static String sSoyad = "Soyisim";  
    public static String sKartNumarası = "Kredi Kartı numarası";  
    
    public static String sSessionCard = "card";  
    


    public static boolean tryParseInt(String value ,Integer i ) {  
     try {  
         i = Integer.parseInt(value);  
         return true;  
      } catch (NumberFormatException e) {  
         return false;  
      }  
}
}
