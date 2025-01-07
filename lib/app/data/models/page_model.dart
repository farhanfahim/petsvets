class PageModel {
  int? id;
  String? slug;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  PageModel({this.id, this.slug, this.title, this.content, this.createdAt, this.updatedAt, this.deletedAt, this.createdAgo});

  PageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_ago'] = this.createdAgo;

    return data;
  }
}


