class SurnameList {
  List<SurnameListResult>? result;
  int? total;

  SurnameList({this.result, this.total});

  SurnameList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <SurnameListResult>[];
      json['result'].forEach((v) {
        result!.add(new SurnameListResult.fromJson(v));
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

class SurnameListResult {
  String? id;
  String? engSurname;
  String? gujSurname;

  SurnameListResult({this.id, this.engSurname, this.gujSurname});

  SurnameListResult.fromJson(Map json) {
    id = json['id'];
    engSurname = json['eng_surname'];
    gujSurname = json['guj_surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eng_surname'] = this.engSurname;
    data['guj_surname'] = this.gujSurname;
    return data;
  }
}