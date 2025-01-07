class AddPetModel {
  List<UserPets>? userPets;
  List<MedicalRecords>? medicalRecords;

  AddPetModel({this.userPets, this.medicalRecords});

  AddPetModel.fromJson(Map<String, dynamic> json) {
    if (json['user_pets'] != null) {
      userPets = <UserPets>[];
      json['user_pets'].forEach((v) {
        userPets!.add(new UserPets.fromJson(v));
      });
    }
    if (json['medical_records'] != null) {
      medicalRecords = <MedicalRecords>[];
      json['medical_records'].forEach((v) {
        medicalRecords!.add(new MedicalRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userPets != null) {
      data['user_pets'] = this.userPets!.map((v) => v.toJson()).toList();
    }
    if (this.medicalRecords != null) {
      data['medical_records'] =
          this.medicalRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPets {
  String? name;
  int? breedId;
  String? breed;

  UserPets({this.name, this.breedId, this.breed});

  UserPets.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    breedId = json['breed_id'];
    breed = json['breed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['breed_id'] = this.breedId;
    data['breed'] = this.breed;
    return data;
  }
}

class MedicalRecords {
  String? path;
  String? type;

  MedicalRecords({this.path, this.type});

  MedicalRecords.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    return data;
  }
}