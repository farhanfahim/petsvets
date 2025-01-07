class LocalLocation {
  String? type;
  List<double>? coordinates;
  String? radius;
  String? address;
  String? city;

  LocalLocation({this.type, this.coordinates, this.radius,this.address,this.city});


  LocalLocation.fromJson(Map<String, dynamic> json,{String? address}) {
    type = json['type'];
    coordinates = (json['coordinates'] as List).map<double>((e){
      return e.toDouble();
    }).toList();
    radius = json['radius'];
    this.address = address??json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    data['radius'] = this.radius;
    data['address'] = this.address;
    return data;
  }
}
