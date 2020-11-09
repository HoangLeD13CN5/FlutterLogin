import 'package:onepay_sign_auth_dart/common/constants/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  * get data example: var username = PreferencesData().getUsername();
  * save data example: PreferencesData().setUsername("David Le");
*/

class PreferencesData {
  static final PreferencesData _singleton = PreferencesData._internal();

  factory PreferencesData() {
    return _singleton;
  }

  PreferencesData._internal();

  Future<void> _saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<int> _readInt(String key, [int value_default = 0])  {
    return SharedPreferences.getInstance().then((prefs) => prefs.getInt(key) ?? value_default);
  }

  Future<void> _saveString(String key, String value) {
    return SharedPreferences.getInstance().then((prefs) => prefs.setString(key, value));
  }

  Future<String> _readString(String key, [String value_default = ""] ) {
    return SharedPreferences.getInstance().then((prefs) => prefs.getString(key) ?? value_default);
  }

  Future<void> _saveDouble(String key, double value) {
    return SharedPreferences.getInstance().then((prefs) => prefs.setDouble(key, value));
  }

  Future<double> _readDouble(String key, [double value_default = 0.0] ) {
    return SharedPreferences.getInstance().then((prefs) => prefs.getDouble(key) ?? value_default);
  }

  Future<void> _saveBool(String key, bool value) {
      return SharedPreferences.getInstance().then((prefs) => prefs.setBool(key, value));
  }

  Future<bool> _readBool(String key, [bool value_default = false] ) {
      return SharedPreferences.getInstance().then((prefs) => prefs.getBool(key) ?? value_default);
  }

  Future<String> getUsername() {
    return _readString(key_pref["USERNAME"]);
  }

  Future<void> saveUsername(String username) {
    return _saveString(key_pref["USERNAME"], username);
  }

  Future<String> getPassword() {
    return _readString(key_pref["PASSWORD"]);
  }

  Future<void> savePassword(String password) {
    return _saveString(key_pref["PASSWORD"], password);
  }
}