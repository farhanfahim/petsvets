import '../enums/image_type.dart';

class Attachments {

  String? name;
  String? url;
  bool? isNetwork;
  final String? extension;
  final ImageType imageType;
  final double? size;
  final List<int> bytes;
  Attachments(
      {this.url, this.name, this.imageType=ImageType.image,
        this.isNetwork = false,
        this.size,
        this.extension,
        this.bytes=const [],
      });

  factory Attachments.fromJson(Map<String, dynamic> json){
    return Attachments(
      url: json["attachment"] ?? "",
      name: json["name"]??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "attachment": url,
      "name":name,
    };
  }

}