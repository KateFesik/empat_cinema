import 'package:cinema/ui/account/widgets/account_app_bar.dart';
import 'package:cinema/ui/common/cinema_button.dart';
import 'package:cinema/ui/account/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/account/account_repository.dart';
import 'block/account_bloc.dart';

const String buttonText = "save changes";

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void _onSave(BuildContext context) {
    context.read<AccountBloc>().add(SaveName(name: nameController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (BuildContext context) => AccountBloc(
        context.read<AccountRepository>(),
      )..add(InitAccount()),
      child: Scaffold(
        appBar: const AccountAppBar(),
        body: BlocConsumer<AccountBloc, AccountState>(
          listener: (BuildContext context, AccountState state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(
                  content: Text(state.errorMessage!),
                ));
            }
            nameController.text = state.name ?? '';
          },
          builder: (BuildContext context, AccountState state) {
            return Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    InputField(
                      hint: "Name",
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      onSubmitted: (value) {
                        _onSave(context);
                      },
                    ),
                    InputField(
                      hint: "Phone number",
                      controller:
                          TextEditingController(text: state.phone ?? ''),
                      keyboardType: TextInputType.phone,
                      enabled: false,
                    ),
                    CinemaButton(
                      onTap: () {
                        _onSave(context);
                      },
                      title: buttonText,
                      isDisabled: true,
                    ),
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
      ),
    );
  }
}
