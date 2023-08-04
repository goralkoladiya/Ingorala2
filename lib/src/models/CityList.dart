class CityList {
  List<CityListResult>? result;
  int? total;

  CityList({this.result, this.total});

  CityList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <CityListResult>[];
      json['result'].forEach((v) {
        result!.add(new CityListResult.fromJson(v));
      });
    }
    total = json['total'];
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

class CityListResult {
  String? id;
  String? engCity;
  String? gujCity;

  CityListResult({this.id, this.engCity, this.gujCity});

  CityListResult.fromJson(Map json) {
    id = json['id'];
    engCity = json['eng_city'];
    gujCity = json['guj_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eng_city'] = this.engCity;
    data['guj_city'] = this.gujCity;
    return data;
  }
}