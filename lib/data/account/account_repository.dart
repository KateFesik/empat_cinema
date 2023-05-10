import 'dart:async';
import 'dart:convert';

import 'package:cinema/data/account/token_cache.dart';
import 'package:cinema/data/network/cinema_rest_client.dart';
import 'package:crypto/crypto.dart';

import '../../ui/app_bloc/app_bloc.dart';
import '../network/model/account.dart';

const _secretKey = "2jukqvNnhunHWMBRRVcZ9ZQ9";

class AccountRepository {
  final CinemaRestClient client;
  final TokenCache tokenCache;

  late final StreamController<AccessToken?> _tokenStreamController;

  AccountRepository(this.client, this.tokenCache) {
    _tokenStreamController =
        StreamController<AccessToken?>.broadcast(onListen: () {
      _tokenStreamController.sink.add(getAccessToken());
    });
  }

  Future<AccessToken> anonymousLogin() async {
    final sessionToken = await client.sessionToken();
    final signature = _anonymousSignature(sessionToken);
    final accessToken = await client.anonymousAccessToken(
      sessionToken,
      signature,
    );
    await tokenCache.saveToken(accessToken);
    await tokenCache.saveAuthenticationType(AuthenticationType.anonymousLogin);
    _tokenStreamController.add(accessToken);
    return accessToken;
  }

  Stream<AccessToken?> accessTokenStream() => _tokenStreamController.stream;

  AccessToken? getAccessToken() {
    return tokenCache.getToken();
  }

  AuthenticationType? getAuthenticationType() {
    return tokenCache.getAuthenticationType();
  }

  void deleteAccessToken() {
    tokenCache.remove();
    _tokenStreamController.add(null);
  }

  String _anonymousSignature(String sessionToken) {
    return _sha256(sessionToken + _secretKey);
  }

  String _sha256(String string) {
    final bytes = utf8.encode(string);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> sendOtp(String phoneNumber) async {
    final isSuccess = await client.sendOtp(phoneNumber);
    return isSuccess;
  }

  Future<AccessToken> otpLogin(String phoneNumber, String otp) async {
    final accessToken = await client.otpAccessToken(phoneNumber, otp);
    await tokenCache.saveToken(accessToken);
    await tokenCache.saveAuthenticationType(AuthenticationType.otpLogin);
    _tokenStreamController.add(accessToken);
    return accessToken;
  }

  Future<Account> getAccountInfo() => client.getAccountInfo();

  Future<Account> saveName(String name) => client.saveName(name);
}
