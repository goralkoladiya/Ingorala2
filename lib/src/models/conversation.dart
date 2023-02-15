
import 'package:flutter/material.dart';

class Contacts {
  int id,fav;
  String cid,name,e_name,address,home_address,contact,contact2,image,business,b_address;

  Contacts(this.id, this.cid,this.name, this.e_name, this.address, this.home_address,
      this.contact, this.contact2, this.image, this.business, this.b_address,this.fav);

  static Contacts fromJson(Map m)
  {
    return Contacts(m['id'], m['cid'],m['name'], m['e_name'], m['address'], m['home_address'],
        m['contact'], m['contact2'], m['image'], m['business'], m['b_address'],m['fav']);
  }

  @override
  String toString() {
    return 'Contacts{id: $id, fav: $fav, cid: $cid, name: $name, e_name: $e_name, address: $address, home_address: $home_address, contact: $contact, contact2: $contact2, image: $image, business: $business, b_address: $b_address}';
  }
}

