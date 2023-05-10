import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/app_bloc/app_bloc.dart';

const _keyToken = "token";
const _keyAuthenticationType = "authentication";

class TokenCache {
  final SharedPreferences prefs;

  TokenCache(this.prefs);

  Future<void> saveToken(String token) async {
    prefs.setString(_keyToken, token);
  }

  String? getToken() => prefs.getString(_keyToken);

  void remove() {
    prefs.remove(_keyToken);
  }

  Future<void> saveAuthenticationType(AuthenticationType type) async {
    prefs.setString(_keyAuthenticationType, EnumToString.convertToString(type));
  }

  AuthenticationType? getAuthenticationType() {
    final String? typeName = prefs.getString(_keyAuthenticationType);
    return (typeName == null)
        ? null
        : EnumToString.fromString(AuthenticationType.values, typeName);
  }
}

