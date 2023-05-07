import 'package:cinema/ui/app_bloc/app_bloc.dart';
import 'package:cinema/ui/cinema_root.dart';
import 'package:cinema/ui/login/login_screen.dart';
import 'package:cinema/ui/common/splash_screen.dart';
import 'package:cinema/ui/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CinemaApp extends StatelessWidget {
  const CinemaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          switch (state.authenticationState) {
            case AuthenticationState.authenticated:
              return CinemaRoot(key: rootKey);
            case AuthenticationState.loginRequired:
              return const LoginScreen();
            case AuthenticationState.initial:
              return const SplashScreen();
          }
        },
      ),
    );
  }
}
