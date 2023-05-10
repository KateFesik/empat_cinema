import 'dart:io';

import 'package:cinema/data/network/model/account.dart';
import 'package:cinema/data/network/model/session.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'model/movie.dart';
import 'model/ticket.dart';

part 'cinema_rest_client_impl.dart';

typedef SessionToken = String;
typedef AccessToken = String;

typedef GetAccessToken = String? Function();

abstract class CinemaRestClient {
  // anonymous
  Future<SessionToken> sessionToken();

  Future<AccessToken> anonymousAccessToken(
    SessionToken sessionToken,
    String signature,
  );

  // otp
  Future<bool> sendOtp(String phoneNumber);

  Future<AccessToken> otpAccessToken(String phoneNumber, String otp);

  // user info
  Future<Account> getAccountInfo();

  Future<Account> saveName(String name);

  // movies
  Future<List<Movie>> searchMovies({
    DateTime? date,
    String? searchQuery,
  });

  Future<List<Session>> searchSessions(
    DateTime? date,
    int? movieId,
  );

  Future<Session> searchSession(
    int? sessionId,
  );

  // reservation
  Future<bool> reservation(
    int sessionId,
    List<int> seatIds,
  );

  //order
  Future<bool> orderTickets(
    int sessionId,
    List<int> seatIds,
      String email,
      String cardNumber,
      String expirationDate,
      String cvv,
  );

  //tickets
Future<List<Ticket>> getTickets();
}
