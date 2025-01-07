import 'add_pet_model.dart';

class AddMorePetModel {
  List<UserPets>? userPets;

  AddMorePetModel({this.userPets});

  AddMorePetModel.fromJson(Map<String, dynamic> json) {
    if (json['user_pets'] != null) {
      userPets = <UserPets>[];
      json['user_pets'].forEach((v) {
        userPets!.add(new UserPets.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userPets != null) {
      data['user_pets'] = this.userPets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
