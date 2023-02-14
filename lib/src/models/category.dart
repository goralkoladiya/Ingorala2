import '../../config/ui_icons.dart';
import 'package:flutter/material.dart';
import '../models/utilities.dart';

class Category {
  String id = UniqueKey().toString();
  String name;
  bool selected;
  IconData icon;
  Color color;
  List<Utilitie> utilities; 

  Category(this.name, this.icon, this.selected,this.color, this.utilities);
}

class SubCategory {
  String id = UniqueKey().toString();
  String name;
  bool selected;
  List<Utilitie> utilities;

  SubCategory(this.name, this.selected, this.utilities);
}

class CategoriesList {
  List<Category> _list=[];

  List<Category> get list => _list;

  CategoriesList() {

    this._list = [
      new Category('Unit', UiIcons.home, false, Colors.blue,[
        new Utilitie('Zogaa FlameSweater', 'img/mall1.jpeg','Health & Fitness', 80,  2554, 3.1, 10.5),
        new Utilitie('Elu Shopping', 'img/elu.png','Business & Finance', 60,  63, 5.0, 20.2),
        new Utilitie('Ritaj Mall', 'img/mall.jpg','Business & Finance', 80,  2554, 3.1, 10.5),
      
      ]),
      new Category('Legend', UiIcons.folder, true,  Colors.cyan, [
        new Utilitie('Lounge Coffee Bar', 'img/coffeebar.jpg','Arts & Humanities',25,  130, 4.3, 12.1),
        new Utilitie('Night Bar', 'img/coffeebar1.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),
        new Utilitie('Summer Coffee', 'img/coffeebar3.jpeg', 'Health & Fitness',25,  130, 4.3, 12.1),
        new Utilitie('Winter Coffee Bar', 'img/coffeebar4.jpg', 'Health & Fitness',25,  130, 4.3, 12.1),

      ]),
      new Category('Maps', UiIcons.map, false, Colors.blueAccent, [
        new Utilitie('Sequins Party Dance Ballet Event', 'img/event2.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        new Utilitie('Cenima film Event', 'img/event3.jpeg','Business & Finance' ,80,  2554, 3.1, 10.5),
        new Utilitie('TomorrowLand Event', 'img/event4.jpg', 'Arts & Humanities',80,  2554, 3.1, 10.5),
        new Utilitie('Creative Design Event', 'img/event1.jpg','Business & Finance' ,80,  2554, 3.1, 10.5),

      ]),
      new Category('Jobseeker', UiIcons.laptop, false, Colors.orange, [
        new Utilitie('WebSite Design ', 'img/jobs2.jpg','Business & Finance', 80, 2554, 3.1, 10.5),
        new Utilitie('House Keeper', 'img/jobs3.jpg','Health & Fitness', 10,  415, 4.9, 15.3),

        
      ]),
      new Category('Restaurant', UiIcons.restaurant, false,  Colors.pinkAccent, [
        new Utilitie('La Mega Pizza', 'img/pizza.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
        new Utilitie('Piano Piano Food', 'img/restaurent.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),

      ]),
      new Category('Automotive', UiIcons.car_1, false,  Colors.deepPurpleAccent,[
        new Utilitie('BMW', 'img/car1.jpg','Coumputers & Technology', 80,  2554, 3.1, 10.5),
        new Utilitie('Rali USA', 'img/car3.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
        new Utilitie('Car Repair', 'img/car2.jpg','Arts & Humanities', 80,  2554, 3.1, 10.5),
        new Utilitie('Mechanical Cars', 'img/car4.jpg','Coumputers & Technology', 80,  2554, 3.1, 10.5),
        
      ]),
      new Category('Sport', UiIcons.sport, false,  Colors.brown,[
        new Utilitie('Roland Gaross', 'img/sport1.jpg','Health & Fitness', 80,  2554, 3.1, 10.5),
        new Utilitie('NBA Competions', 'img/sport2.jpeg','Health & Fitness', 80,  2554, 3.1, 10.5),
        new Utilitie('Gym', 'img/gym.jpg','Health & Fitness', 10,  415, 4.9, 15.3),

       
      ]),
      new Category('Travel', UiIcons.tent, true, Colors.redAccent,[
        new Utilitie('California', 'img/chicagoTavel.jpg','Arts & Humanities', 60,  63, 5.0, 20.2),
        new Utilitie('Colorado', 'img/colorado.jpg','Arts & Humanities', 25,  130, 4.3, 12.1),
        new Utilitie('Paris', 'img/paris.jpg','Arts & Humanities', 35,  130, 6.3, 11.1), 
        new Utilitie('Marriott', 'img/marriott.jpg','Arts & Humanities', 10,  415, 4.9, 15.3),
        new Utilitie('Hilton Hotel', 'img/hilton.webp','Coumputers & Technology',  200, 63, 5.0, 20.2),


      ]),
    ];
  }

  selectById(String id) {
    this._list.forEach((Category category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
  }

  void clearSelection() {
    _list.forEach((category) {
      category.selected = false;
    });
  }
}

class SubCategoriesList {
  List<SubCategory> _list=[];

  List<SubCategory> get list => _list;

  /*SubCategoriesList() {
    this._list = [
      new SubCategory('Arts & Humanities', true, [
        new Utilitie('Zogaa FlameSweater', 'img/man1.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Men Polo Shirt Brand Clothing', 'img/man2.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Polo Shirt for Men', 'img/man3.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Men\'s Sport Pants Long Summer', 'img/man4.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Men\'s Hoodies Pullovers Striped', 'img/man5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Men Double Breasted Suit Vests', 'img/man6.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Puimentiua Summer Fashion', 'img/man7.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Casual Sweater fashion Jacket', 'img/man8.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new SubCategory('Health & Fitness', true, [
        new Utilitie('Summer Fashion Women Dress', 'img/pro5.webp', 'Arts & Humanities',25, 19.64, 200, 130, 4.3, 12.1),
        new Utilitie('Women Half Sleeve', 'img/pro6.webp','Arts & Humanities', 60, 94.36, 200, 42, 5.0, 20.2),
        new Utilitie('Elegant Plaid Dresses Women Fashion', 'img/pro7.webp', 'Arts & Humanities',10, 15.73, 200, 415, 4.9, 15.3),
        new Utilitie('Maxi Dress For Women Summer', 'img/pro1.webp','Arts & Humanities', 25, 19.64, 200, 130, 4.3, 12.1),
        new Utilitie('Black Checked Retro Hepburn Style', 'img/pro2.webp', 'Arts & Humanities',60, 94.36, 200, 63, 5.0, 20.2),
        new Utilitie('Robe pin up Vintage Dress Autumn', 'img/pro3.webp', 'Arts & Humanities',10, 15.73, 200, 415, 4.9, 15.3),
        new Utilitie('Elegant Casual Dress', 'img/pro4.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new SubCategory('Business & Finance', true, [
        new Utilitie('Fashion Baby Sequins Party Dance Ballet', 'img/baby1.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Children Martin Boots PU Leather', 'img/baby2.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Baby Boys Denim Jacket', 'img/baby3.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Mom and Daughter Matching Women', 'img/baby4.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Unicorn Pajamas Winter Flannel Family', 'img/baby5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Party Decorations Kids', 'img/baby6.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new SubCategory('Coumputers & Technology', true, [
        new Utilitie('Yosoo Knee pad Elastic', 'img/sport4.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Spring Hand Grip Finger Strength', 'img/sport5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Knee Sleeves', 'img/sport6.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Brothock Professional basketball socks', 'img/sport7.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('New men s running trousers', 'img/sport8.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Cotton Elastic Hand Arthritis', 'img/sport9.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Spring Half Finger Outdoor Sports', 'img/sport10.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new SubCategory('Leisure & Tavel', true, [
        new Utilitie('Cooking Tools Set Premium', 'img/home1.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Reusable Metal Drinking Straws', 'img/home2.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Absorbent Towel Face', 'img/home3.webp', 'Arts & Humanities',80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Pair Heat Resistant Thick Silicone', 'img/home4.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Electric Mosquito Killer Lamp', 'img/home5.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Terrarium Hydroponic Plant Vases', 'img/home6.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Utilitie('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp','Arts & Humanities', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
    ];
  }*/

  selectById(String id) {
    this._list.forEach((SubCategory subCategory) {
      subCategory.selected = false;
      if (subCategory.id == id) {
        subCategory.selected = true;
      }
    });
  }

  void clearSelection() {
    _list.forEach((category) {
      category.selected = false;
    });
  }
}
