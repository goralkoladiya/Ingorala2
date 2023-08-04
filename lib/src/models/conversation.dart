
import 'package:flutter/material.dart';

class Contacts {
  String id;
  String _key="";
  int fav;
  String cid,name,e_name,address,home_address,contact,contact2,image,business,b_address;

  Contacts(this.id, this.cid,this.name, this.e_name, this.address, this.home_address,
      this.contact, this.contact2, this.image, this.business, this.b_address,this.fav);

  String get key => _key;

  set key(String value) {
    _key = value;
  }

  static Contacts fromJson(Map m)
  {
    return Contacts(m['id'], m['cid'],m['name'], m['e_name'], m['address'], m['home_address'],
        m['contact'], m['contact2'], m['image'], m['business'], m['b_address'],m['fav']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['e_name'] = this.e_name;
    data['address'] = this.address;
    data['home_address'] = this.home_address;
    data['contact'] = this.contact;
    data['contact2'] = this.contact2;
    data['image'] = this.image;
    data['business'] = this.business;
    data['b_address'] = this.b_address;
    data['cid'] = this.cid;
    data['fav'] = this.fav;
    return data;
  }


  @override
  String toString() {
    return 'Contacts{id: $id, fav: $fav, cid: $cid, name: $name, e_name: $e_name, address: $address, home_address: $home_address, contact: $contact, contact2: $contact2, image: $image, business: $business, b_address: $b_address}';
  }
}

