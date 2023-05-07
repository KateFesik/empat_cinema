import 'package:shared_preferences/shared_preferences.dart';

const _keyToken = "token";

class TokenCache {
  final SharedPreferences prefs;

  TokenCache(this.prefs);

  Future<void> save(String token) async {
    prefs.setString(_keyToken, token);
  }

  String? getToken() => prefs.getString(_keyToken);

  void remove() {
    prefs.remove(_keyToken);
  }
}
