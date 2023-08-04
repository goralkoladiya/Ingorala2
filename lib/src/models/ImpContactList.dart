class ImpContactList {
  List<ImpContactListResult>? result;
  int? total;

  ImpContactList({this.result, this.total});

  ImpContactList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ImpContactListResult>[];
      json['result'].forEach((v) {
        result!.add(new ImpContactListResult.fromJson(v));
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

class ImpContactListResult {
  String? id;
  String? gujName;
  String? engName;
  String? number;

  ImpContactListResult({this.id, this.gujName, this.engName, this.number});

  ImpContactListResult.fromJson(Map json) {
    id = json['id'];
    gujName = json['guj_name'];
    engName = json['eng_name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guj_name'] = this.gujName;
    data['eng_name'] = this.engName;
    data['number'] = this.number;
    return data;
  }
}