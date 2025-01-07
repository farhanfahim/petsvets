import 'package:petsvet_connect/app/data/models/common_models/language_item.dart';

class Language {
  LanguageItem? english;
  LanguageItem? arabic;
  LanguageItem? urdu;

  Language({this.english, this.arabic, this.urdu});

  Language.fromJson(Map<String, dynamic> json) {
    english = json['english'] != null ? LanguageItem.fromJson(json['english']) : null;
    arabic = json['arabic'] != null ? LanguageItem.fromJson(json['arabic']) : null;
    urdu = json['urdu'] != null ? LanguageItem.fromJson(json['urdu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (english != null) {
      data['english'] = english!.toJson();
    }
    if (arabic != null) {
      data['arabic'] = arabic!.toJson();
    }
    if (urdu != null) {
      data['urdu'] = urdu!.toJson();
    }
    return data;
  }
}
