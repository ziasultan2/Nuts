class AlmondType{
  int id;
  String type;

  AlmondType({this.id, this.type});

  factory AlmondType.fromJson(Map<String, dynamic> json) {
    return AlmondType(
      id: json['id'],
      type: json['type'],
    );
  }
}