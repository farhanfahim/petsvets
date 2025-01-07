class Permission {
  String? name;
  bool? canAdd;
  bool? canUpdate;
  bool? canDelete;
  bool? canView;

  Permission({this.name, this.canAdd, this.canUpdate, this.canDelete, this.canView});

  Permission.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    canAdd = json['canAdd'];
    canUpdate = json['canUpdate'];
    canDelete = json['canDelete'];
    canView = json['canView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['canAdd'] = canAdd;
    data['canUpdate'] = canUpdate;
    data['canDelete'] = canDelete;
    data['canView'] = canView;
    return data;
  }
}
