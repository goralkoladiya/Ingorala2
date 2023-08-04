class BusinessList {
  List<BusinessListResult>? result;
  int? total;

  BusinessList({this.result, this.total});

  BusinessList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <BusinessListResult>[];
      json['result'].forEach((v) {
        result!.add(new BusinessListResult.fromJson(v));
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

class BusinessListResult {
  String? id;
  String? category;
  String _key="";
  BusinessListResult({this.id, this.category});

  String get key => _key;

  set key(String value) {
    _key = value;
  }

  BusinessListResult.fromJson(Map json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}