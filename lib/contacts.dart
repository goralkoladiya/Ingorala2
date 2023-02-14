
import 'package:objectbox/objectbox.dart';
import 'objectbox.g.dart';

@Entity()
class contacts {
  @Id()
  int id1 = 0;
  @Index()
  String? id;
  String? name;
  String? eName;
  String? address;
  String? homeAddress;
  String? contact;
  String? contact2;
  String? image;
  String? business;
  String? bAddress;
  int _favourite=0;


  int get favourite => _favourite;

  set favourite(int value) {
    _favourite = value;
  }

  contacts(
      {this.id,
        this.name,
        this.eName,
        this.address,
        this.homeAddress,
        this.contact,
        this.contact2,
        this.image,
        this.business,
        this.bAddress});

  contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    eName = json['e_name'];
    address = json['address'];
    homeAddress = json['home_address'];
    contact = json['contact'];
    contact2 = json['contact2'];
    image = json['image'];
    business = json['business'];
    bAddress = json['b_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['e_name'] = this.eName;
    data['address'] = this.address;
    data['home_address'] = this.homeAddress;
    data['contact'] = this.contact;
    data['contact2'] = this.contact2;
    data['image'] = this.image;
    data['business'] = this.business;
    data['b_address'] = this.bAddress;
    return data;
  }


}