import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petsvet_connect/utils/constants.dart';

import '../app/data/models/user_model.dart';

class AppPreferences {
  static late final SharedPreferences _preferences;

  static Future<SharedPreferences> init() async => _preferences = await SharedPreferences.getInstance();

  AppPreferences._internal();

  static const String _prefTypeBool = "BOOL";
  static const String _prefTypeInteger = "INTEGER";
  static const String _prefTypeDouble = "DOUBLE";
  static const String _prefTypeString = "STRING";

  /// Constants for Preference-Keys
  static const String _userId = "USER_ID";
  static const String _userDetails = "USER_DETAILS";
  static const String _accessToken = "ACCESS_TOKEN";
  static const String _loggedIn = "IS_LOGGED_IN";
  static const String _role = "ROLE";
  static const String _theme = "theme";
  static const String _language = "language";
  static const String _latitude = "latitude";
  static const String _longitude = "longitude";

  //--------------------------------------------------- Public Preference Methods -------------------------------------------------------------
  static void removeValue({required String key}) {
    _preferences.remove(key);
  }

  static void setUserId({required String userId}) => _setPreference(prefName: _userId, prefValue: userId, prefType: _prefTypeString);

  static Future<String> getUserId() async => await _getPreference(prefName: _userId);

  static void setRole({required String role}) => _setPreference(prefName: _role, prefValue: role, prefType: _prefTypeString);
  static String getRole() {return _getPreference(prefName: _role) ?? Constants.rolePet;}


  static Future<bool> setUserDetails({required UserModel user}) =>
      _setPreference(prefName: _userDetails, prefValue: jsonEncode(user), prefType: _prefTypeString);

  static Future<UserModel?> getUserDetails() async {
    if (_preferences.getString(_userDetails) == null) return null;
    Map<String, dynamic> userMap = jsonDecode(_preferences.getString(_userDetails)!);
    var userDetails = UserModel.fromJson(userMap);
    return userDetails;
  }

  static Future<bool> setAccessToken({required String token}) => _setPreference(prefName: _accessToken, prefValue: token, prefType: _prefTypeString);

  static Future<String> getAccessToken() async => (await _getPreference(prefName: _accessToken)) ?? "";

  static void setIsLoggedIn({required bool loggedIn}) => _setPreference(prefName: _loggedIn, prefValue: loggedIn, prefType: _prefTypeBool);

  static bool getIsLoggedIn() {
    return _preferences.getBool(_loggedIn) ?? false;
  }

  static Future<bool> setIsDarkTheme({required bool darkTheme}) => _setPreference(prefName: _theme, prefValue: darkTheme, prefType: _prefTypeBool);

  static bool getIsDarkTheme() {
    return _preferences.getBool(_theme) ?? true;
  }

  static Future<bool> setCurrentLanguage({required String language}) =>
      _setPreference(prefName: _language, prefValue: language, prefType: _prefTypeString);

  static String getCurrentLanguage() {
    return _getPreference(prefName: _language) ?? Constants.english;
  }

  static Future<bool> setPageData({required String data, required String page}) =>
      _setPreference(prefName: page, prefValue: data, prefType: _prefTypeString);

  static Future<String?> getPageData({required String page}) async => await _getPreference(prefName: page);

  //--------------------------------------------------- Private Preference Methods ----------------------------------------------------
  /// @usage -> This is a generalized method to set preferences with required Preference-Name(Key) with Preference-Value(Value) and Preference-Value's data-type.
  static Future<bool> _setPreference({required String prefName, required dynamic prefValue, required String prefType}) async {
    switch (prefType) {
      case _prefTypeBool:
        return _preferences.setBool(prefName, prefValue);
      case _prefTypeInteger:
        return _preferences.setInt(prefName, prefValue);
      case _prefTypeDouble:
        return _preferences.setDouble(prefName, prefValue);
      case _prefTypeString:
        return _preferences.setString(prefName, prefValue);
      default:
        return Future.value(false);
    }
  }


  static dynamic _getPreference({required prefName}) => _preferences.get(prefName);

  static Future<bool> setLatitude({required double latitude}) =>
      _setPreference(prefName: _latitude, prefValue: latitude, prefType: _prefTypeDouble);

  static double getLatitude() {
    return _getPreference(prefName: _latitude) ?? 0.0;
  }

  static Future<bool> setLongitude({required double longitude}) =>
      _setPreference(prefName: _longitude, prefValue: longitude, prefType: _prefTypeDouble);

  static double getLongitude() {
    return _getPreference(prefName: _longitude) ?? 0.0;
  }

  static Future<bool> clearPreference() => _preferences.clear();
}
