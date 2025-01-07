class AddVetModel {
  String? stateLicense;
  String? stateLicenseNumber;
  String? about;
  double? latitude;
  double? longitude;
  String? deaNumber;
  String? nationalLicenseNumber;
  String? regNumber;
  int? vetType;
  List<LicenseDocuments>? licenseDocuments;
  List<VetSpecializations>? vetSpecializations;
  String? startTime;
  String? endTime;

  AddVetModel(
      {this.stateLicense,
        this.stateLicenseNumber,
        this.about,
        this.deaNumber,
        this.latitude,
        this.longitude,
        this.nationalLicenseNumber,
        this.regNumber,
        this.vetType,
        this.licenseDocuments,
        this.vetSpecializations,
        this.startTime,
        this.endTime});

  AddVetModel.fromJson(Map<String, dynamic> json) {
    stateLicense = json['state_license'];
    stateLicenseNumber = json['state_license_number'];
    about = json['about'];
    deaNumber = json['dea_number'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nationalLicenseNumber = json['national_license_number'];
    regNumber = json['reg_number'];
    vetType = json['vet_type'];
    if (json['license_documents'] != null) {
      licenseDocuments = <LicenseDocuments>[];
      json['license_documents'].forEach((v) {
        licenseDocuments!.add(new LicenseDocuments.fromJson(v));
      });
    }
    if (json['vet_specializations'] != null) {
      vetSpecializations = <VetSpecializations>[];
      json['vet_specializations'].forEach((v) {
        vetSpecializations!.add(new VetSpecializations.fromJson(v));
      });
    }
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_license'] = this.stateLicense;
    data['state_license_number'] = this.stateLicenseNumber;
    data['about'] = this.about;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['dea_number'] = this.deaNumber;
    data['national_license_number'] = this.nationalLicenseNumber;
    data['reg_number'] = this.regNumber;
    data['vet_type'] = this.vetType;
    if (this.licenseDocuments != null) {
      data['license_documents'] =
          this.licenseDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.vetSpecializations != null) {
      data['vet_specializations'] =
          this.vetSpecializations!.map((v) => v.toJson()).toList();
    }
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

class LicenseDocuments {
  String? path;
  String? type;

  LicenseDocuments({this.path, this.type});

  LicenseDocuments.fromJson(Map<String, dynamic> json) {
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

class VetSpecializations {
  int? petType;

  VetSpecializations({this.petType});

  VetSpecializations.fromJson(Map<String, dynamic> json) {
    petType = json['pet_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pet_type'] = this.petType;
    return data;
  }
}