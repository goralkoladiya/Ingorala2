class AdvBannerList {
  int? total;
  List<AdvBannerListResult>? result;

  AdvBannerList({this.total, this.result});

  AdvBannerList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['result'] != null) {
      result = <AdvBannerListResult>[];
      json['result'].forEach((v) {
        result!.add(new AdvBannerListResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvBannerListResult {
  String? id;
  String? note;
  String? image;

  AdvBannerListResult({this.id, this.note, this.image});

  AdvBannerListResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['image'] = this.image;
    return data;
  }
}