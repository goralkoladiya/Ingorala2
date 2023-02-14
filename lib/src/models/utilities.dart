import 'package:flutter/material.dart';
class Utilitie{
  String id = UniqueKey().toString();
  String name;
  String image;
  String type;
  double price;
  int available;
  double rate;
  double discount;
  
  Utilitie(this.name, this.image,this.type,this.available, this.price, this.rate, this.discount);

  String getPrice({double? myPrice}) {
    if (myPrice != null) {
      return '\$${myPrice.toStringAsFixed(2)}';
    }
    return '\$${this.price.toStringAsFixed(2)}';
  }
}
class UtilitiesList {
  List<Utilitie> _popularList=[];
  List<Utilitie> _list=[];
  List<Utilitie> _recentList=[];
  List<Utilitie> _favoritesList=[];
  List<Utilitie> _cartList=[];

  //set recentList(List<Utilitie> value) {
    //_recentList = value;
  //}

  List<Utilitie> get recentList => _recentList;
  List<Utilitie> get list => _list;
  List<Utilitie> get popularList => _popularList;
  List<Utilitie> get favoritesList => _favoritesList;
  List<Utilitie> get cartList => _cartList;

  UtilitiesList() {
    _recentList =[
      new Utilitie('Lounge Coffee Bar', 'img/coffeebar.jpg','Arts & Humanities',25,  130, 4.3, 12.1),
      new Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 60,  63, 5.0, 20.2),
      new Utilitie('Smart Gym', 'img/gym.jpg','Health & Fitness', 10,  415, 4.9, 15.3),
      new Utilitie('La Mega Pizza', 'img/pizza.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
    ];
    
    _popularList = [
      new Utilitie('Colorado', 'img/colorado.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
      new Utilitie('Marriott', 'img/marriott.jpg','Arts & Humanities', 10,  415, 4.9, 15.3),
      new Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80,  2554, 3.1, 10.5),
      new Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
      new Utilitie('Managment Event', 'img/event1.jpg', 'Arts & Humanities',80,  2554, 3.1, 10.5),

    ];

    _list = [
        new Utilitie('Zogaa FlameSweater', 'img/man1.webp','Health & Fitness', 80, 2554, 3.1, 10.5),
        new Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
        new Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80,  2554, 3.1, 10.5),

        new Utilitie('Lounge Coffee Bar', 'img/coffeebar.jpg','Arts & Humanities',25,  130, 4.3, 12.1),
        new Utilitie('Night Bar', 'img/coffebar1.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),
        new Utilitie('Summer Coffee', 'img/coffebar4.jpeg', 'Health & Fitness',25,  130, 4.3, 12.1),
        new Utilitie('Winter Coffee Bar', 'img/coffebar3.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),

        new Utilitie('Sequins Party Dance Ballet Event', 'img/event2.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        new Utilitie('Cenima film Event', 'img/event3.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        new Utilitie('Managment Event', 'img/event1.jpg', 'Arts & Humanities',80,  2554, 3.1, 10.5),
        new Utilitie('Creative Design Event', 'img/event1.jpeg','Business & Finance' ,80, 2554, 3.1, 10.5),

        new Utilitie('BMW', 'img/car1.jpg','Coumputers & Technology', 80, 2554, 3.1, 10.5),
        new Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
        new Utilitie('Car Repair', 'img/car2.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
        new Utilitie('Mechanical Cars', 'img/car4.jpg','Coumputers & Technology', 80,  2554, 3.1, 10.5),

        new Utilitie('La Mega Pizza', 'img/pizza.jpg','Arts & Humanities', 25, 130, 4.3, 12.1),

        new Utilitie('Roland Gaross', 'img/sport1.jpg','Health & Fitness', 80,  2554, 3.1, 10.5),
        new Utilitie('NBA Competions', 'img/sport2.jpeg','Health & Fitness', 80,  2554, 3.1, 10.5),
        new Utilitie('Smart Gym', 'img/gym.jpg','Health & Fitness', 10,  415, 4.9, 15.3),

        new Utilitie('California', 'img/chicagoTavel.jpg','Arts & Humanities', 60,  63, 5.0, 20.2),
        new Utilitie('Colorado', 'img/colorado.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
        new Utilitie('Paris', 'img/paris.jpg','Arts & Humanities', 35, 130, 6.3, 11.1), 
        new Utilitie('Marriott', 'img/marriott.jpg','Arts & Humanities', 10,  415, 4.9, 15.3),
        new Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 60,  63, 5.0, 20.2),


    ];

    _favoritesList = [
      new Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
      new Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80, 2554, 3.1, 10.5),
      new Utilitie('Roland Gaross', 'img/sport1.jpg','Health & Fitness', 80,  2554, 3.1, 10.5),
      new Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 200, 63, 5.0, 20.2),
      new Utilitie('California', 'img/chicagoTavel.jpg','Arts & Humanities', 60,  63, 5.0, 20.2),
      new Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),

    ];

    _cartList = [
        new Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology', 60, 63, 5.0, 20.2),
        new Utilitie('Smart Gym', 'img/gym.jpg','Health & Fitness', 10, 415, 4.9, 15.3),
        new Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 200, 63, 5.0, 20.2),
        new Utilitie('Managment Event', 'img/event1.jpg', 'Arts & Humanities',80, 2554, 3.1, 10.5),


    ];
  }
}