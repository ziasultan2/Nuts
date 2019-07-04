class AlmondSize{
  int id;
  String type;

  AlmondSize({this.id, this.type});

  factory AlmondSize.fromJson(Map<String, dynamic> json) {
    return AlmondSize(
      id: json['id'],
      type: json['type'],
    );
  }
}