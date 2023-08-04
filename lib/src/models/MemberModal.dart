class Members {
  List<Result>? result;
  int? total;

  @override
  String toString() {
    return 'Members{result: $result, total: $total}';
  }

  Members({this.result, this.total});

  Members.fromJson(Map json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    total = json['total'];
  }
  Members.from(Map json) {
    if(json!=null)
      {
        result = <Result>[];
      }
    json.forEach((key, value) {
      result!.add(new Result.fromJson(value));
    });
    total = json.length;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Result {
  String _key="";
  String? id;
  String? fullName;
  String? engName;
  String? contact1;
  String? contact2;
  String? address;
  String? city;
  String? occupation;

  @override
  String toString() {
    return 'Result{_key: $_key, id: $id, fullName: $fullName, engName: $engName, contact1: $contact1, contact2: $contact2, address: $address, city: $city, occupation: $occupation, businessCategory: $businessCategory, subOccupation: $subOccupation, businessAddress: $businessAddress, image: $image}';
  }

  String? businessCategory;
  String? subOccupation;
  String? businessAddress;
  String? image;
  String get key => _key;

  set key(String value) {
    _key = value;
  }
  Result(
      {this.id,
        this.fullName,
        this.engName,
        this.contact1,
        this.contact2,
        this.address,
        this.city,
        this.occupation,
        this.businessCategory,
        this.subOccupation,
        this.businessAddress,
        this.image});

  Result.fromJson(Map json) {
    id = json['id'];
    fullName = json['full_name'];
    engName = json['eng_name'];
    contact1 = json['contact1'];
    contact2 = json['contact2'];
    address = json['address'];
    city = json['city'];
    occupation = json['occupation'];
    businessCategory = json['business_category'];
    subOccupation = json['sub_occupation'];
    businessAddress = json['business_address'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['eng_name'] = this.engName;
    data['contact1'] = this.contact1;
    data['contact2'] = this.contact2;
    data['address'] = this.address;
    data['city'] = this.city;
    data['occupation'] = this.occupation;
    data['business_category'] = this.businessCategory;
    data['sub_occupation'] = this.subOccupation;
    data['business_address'] = this.businessAddress;
    data['image'] = this.image;
    return data;
  }
}