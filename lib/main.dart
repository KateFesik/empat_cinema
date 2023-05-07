import 'package:cinema/data/account/account_repository.dart';
import 'package:cinema/data/network/cinema_rest_client.dart';
import 'package:cinema/ui/app_bloc/app_bloc.dart';
import 'package:cinema/ui/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:print_lumberdash/print_lumberdash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cinema_app.dart';
import 'data/account/token_cache.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // setup logger
  putLumberdashToWork(withClients: [PrintLumberdash()]);

  runApp(MultiProvider(
    providers: [
      Provider<TokenCache>(
        create: (context) => TokenCache(prefs),
      ),
      Provider<CinemaRestClient>(
        create: (context) => CinemaRestClientImpl(
          context.read<TokenCache>().getToken,
        ),
      ),
      Provider<AccountRepository>(
        create: (context) => AccountRepository(
          context.read<CinemaRestClient>(),
          context.read<TokenCache>(),
        ),
      ),
      BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(
          context.read<TokenCache>(),
          context.read<AccountRepository>(),
        ),
      ),
      BlocProvider<AppBloc>(
        create: (context) => AppBloc(
          context.read<AccountRepository>(),
        ),
      )
    ],
    child: const CinemaApp(),
  ));
}
