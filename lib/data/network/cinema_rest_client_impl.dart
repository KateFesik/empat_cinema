part of 'cinema_rest_client.dart';

const _baseUrl = "https://fs-mt.qwerty123.tech";

final _dateFormat = DateFormat("yyyy-MM-dd");

class CinemaRestClientImpl extends CinemaRestClient {
  final dio = Dio();

  CinemaRestClientImpl(GetAccessToken getAccessToken) {
    dio.interceptors.add(PrettyDioLogger(requestBody: true));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        if (!options.path.contains("api/auth")) {
          final token = getAccessToken();
          if (token == null) {
            throw LoginRequiredException("Unable to get access token");
          }
          options.headers["Authorization"] = "Bearer $token";
        }
        handler.next(options);
      },
    ));

    dio.options.baseUrl = _baseUrl;
    dio.options.headers["Accept-Language"] = "en";
  }

  @override
  Future<SessionToken> sessionToken() async {
    final dioResponse = await dio.post<Map<String, dynamic>>(
      '/api/auth/session',
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    return dioResponse.data!['data']['sessionToken'] as String;
  }

  @override
  Future<AccessToken> anonymousAccessToken(
    String sessionToken,
    String signature,
  ) async {
    final data = {
      "sessionToken": sessionToken,
      "signature": signature,
    };
    final dioResponse = await dio.post<Map<String, dynamic>>(
      '/api/auth/token',
      data: data,
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    // must be accessToken instead of sessionToken. There's a typo on server
    return dioResponse.data!['data']['sessionToken'] as String;
  }

  @override
  Future<bool> sendOtp(String phoneNumber) async {
    final data = {
      "phoneNumber": phoneNumber,
    };
    final dioResponse = await dio.post<Map<String, dynamic>>(
      '/api/auth/otp',
      data: data,
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    return dioResponse.data!['data'] as bool;
  }

  @override
  Future<AccessToken> otpAccessToken(String phoneNumber, String otp) async {
    final dioResponse = await dio.post<Map<String, dynamic>>(
      '/api/auth/login',
      data: {
        "phoneNumber": phoneNumber,
        "otp": otp,
      },
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    return dioResponse.data!['data']['accessToken'] as AccessToken;
  }

  @override
  Future<Account> getAccountInfo() async {
    final dioResponse = await dio.get<Map<String, dynamic>>(
      '/api/user',
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    return Account.fromJson(dioResponse.data!['data']);
  }

  @override
  Future<Account> saveName(String name) async {
    final dioResponse =
        await dio.post<Map<String, dynamic>>('/api/user', data: {
      "name": name,
    });
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    final dataJson = dioResponse.data!['data'];
    return Account.fromJson(dataJson);
  }

  @override
  Future<List<Movie>> searchMovies({
    DateTime? date,
    String? searchQuery,
  }) async {
    final dioResponse = await dio.get<Map<String, dynamic>>(
      '/api/movies',
      queryParameters: {
        if (date != null) 'date': _dateFormat.format(date),
        if (searchQuery != null) 'query': searchQuery,
      },
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    final dataJson = dioResponse.data!['data'];
    return (dataJson as List<dynamic>)
        .map((jsonObject) => Movie.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<Session>> searchSessions(
    DateTime? date,
    int? movieId,
  ) async {
    final dioResponse = await dio.get<Map<String, dynamic>>(
      '/api/movies/sessions',
      queryParameters: {
        if (movieId != null) 'movieId': movieId,
        if (date != null) 'date': _dateFormat.format(date),
      },
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    final dataJson = dioResponse.data!['data'] as List<dynamic>;
    return dataJson.map((e) => Session.fromJson(e)).toList();
  }

  @override
  Future<Session> searchSession(int? sessionId) async {
    final dioResponse = await dio.get<Map<String, dynamic>>(
      '/api/movies/sessions/$sessionId',
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    final dataJson = dioResponse.data!['data'];
    return Session.fromJson(dataJson);
  }

  @override
  Future<bool> reservation(int sessionId, List<int> seatIds) async {
    final data = {
      "seats": seatIds,
      "sessionId": sessionId,
    };
    final dioResponse = await dio.post<Map<String, dynamic>>(
      '/api/movies/book',
      data: data,
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    return dioResponse.data!['data'] as bool;
  }

  @override
  Future<bool> orderTickets(
    int sessionId,
    List<int> seatIds,
    String email,
    String cardNumber,
    String expirationDate,
    String cvv,
  ) async {
    final data = {
      "seats": seatIds,
      "sessionId": sessionId,
      "email": email,
      "cardNumber": cardNumber,
      "expirationDate": expirationDate,
      "cvv": cvv,
    };
    final dioResponse = await dio.post<Map<String, dynamic>>(
      "/api/movies/buy",
      data: data,
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    return dioResponse.data!['data'] as bool;
  }

  @override
  Future<List<Ticket>> getTickets() async {
    final dioResponse = await dio.get<Map<String, dynamic>>(
      "/api/user/tickets",
    );
    if (dioResponse.success()) {
      throw Exception("Request failed");
    }
    final dataJson = dioResponse.data!['data'];
    return (dataJson as List<dynamic>)
        .map((jsonObject) => Ticket.fromJson(jsonObject))
        .toList();
  }
}

extension ResponseExt<T> on Response<Map<String, dynamic>> {
  bool success() => statusCode != 200 && (data!['success'] as bool);
}

class LoginRequiredException extends IOException {
  final String message;

  LoginRequiredException(this.message);
}
