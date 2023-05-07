import 'package:cinema/ui/login/bloc/login_bloc.dart';
import 'package:cinema/ui/login/widgets/authentication_button.dart';
import 'package:cinema/ui/login/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String _logo = "Empat Cinema";
const String _anonymous = "Enter without login";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController;
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    otpController.dispose();
  }

  void _onSubmitPhone(BuildContext context) {
    context.read<LoginBloc>().add(SubmitPhone(phone: phoneController.text));
  }

  void _onSubmitOtp(BuildContext context) {
    context.read<LoginBloc>().add(SubmitOtp(otp: otpController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(state.errorMessage!),
              ));
            context.read<LoginBloc>().add(OnErrorShown());
          }
        },
        builder: (BuildContext context, LoginState state) {
          return Stack(
            children: [
              Column(
                children: [
                  Flexible(flex: 1, child: Container()),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _logo,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 80.0,
                      ),
                      OtpForm(
                        showOtp: state.isOtpSent,
                        onPhoneSubmitted: (value) {
                          _onSubmitPhone(context);
                        },
                        onOtpSubmitted: (value) {
                          _onSubmitOtp(context);
                        },
                        phoneController: phoneController,
                        otpController: otpController,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      AuthenticationButton(onSubmitted: () {
                        if (!state.isOtpSent) {
                          _onSubmitPhone(context);
                        } else {
                          _onSubmitOtp(context);
                        }
                      }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(AnonymousLogin());
                        },
                        child: const Text(_anonymous),
                      ),
                    ],
                  ),
                  Flexible(flex: 2, child: Container()),
                ],
              ),
              if (state.loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
