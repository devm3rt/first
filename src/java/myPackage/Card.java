/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myPackage;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * Bu class Sessionda tutmamız gereken uçuş bilgileri listesi için kullanılmaktadır.
 */
public class Card {

    // Uçuş bilgilerinin tuutlacağı alan
    private List<Integer> _flightList;

    // Liste değişkeni için singleton yapısı
    private List<Integer> List() {
        if (_flightList == null) {
            _flightList = new ArrayList<Integer>();
        }
        return _flightList;
    }
    
    // Liste için getter
    public List<Integer> getFligtIdList() {
        return List();
    }

    //Listeye ekelem yaparken kullanılacak olan metod
    public void addToFlightIdList(int i) {
        if (!List().contains(i)) {
            List().add(i);
        }
    }
    
    //Listeden çıkarmak için kullanılacak metod
    public void removeFromList(int i) {
        if (List().contains(i)) {
            List().remove(((Integer) i));
        }
        
    }

}
