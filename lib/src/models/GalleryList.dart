class GalleryList {
  int? total;
  List<GalleryListResult>? result;

  GalleryList({this.total, this.result});

  GalleryList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['result'] != null) {
      result = <GalleryListResult>[];
      json['result'].forEach((v) {
        result!.add(new GalleryListResult.fromJson(v));
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

class GalleryListResult {
  String? id;
  String? image;

  GalleryListResult({this.id, this.image});

  GalleryListResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}