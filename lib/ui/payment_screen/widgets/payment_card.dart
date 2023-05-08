import 'package:cinema/ui/payment_screen/bloc/payment_bloc.dart';
import 'package:cinema/ui/payment_screen/widgets/payment_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../common/cinema_button.dart';

const String _buttonText = "order";
const String _emailHint =
    "To purchase a ticket, please enter your email address.";
const String _cardHint = "Enter your card details.";
const String _email = "email";
const String _cardNumber = "card number";
const String _expirationDate = "expiration date";
const String _cvv = "cvv";

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  late final TextEditingController emailController;
  late final TextEditingController cardNumberController;
  late final TextEditingController expirationDateController;
  late final TextEditingController cvvController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    cardNumberController = TextEditingController();
    expirationDateController = TextEditingController();
    cvvController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    cardNumberController.dispose();
    expirationDateController.dispose();
    cvvController.dispose();
  }

  void _onOrder(BuildContext context) {
    context.read<PaymentBloc>().add(OnOrder(
          email: emailController.text,
          cardNumber: cardNumberController.text,
          expirationDate: expirationDateController.text,
          cvv: cvvController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextHint(
                  title: _emailHint,
                ),
                PaymentField(
                  hint: _email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10.0),
                const TextHint(
                  title: _cardHint,
                ),
                PaymentField(
                  hint: _cardNumber,
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cardMaskFormatter],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: PaymentField(
                        hint: _expirationDate,
                        controller: expirationDateController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [_expirationDateMaskFormatter],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: PaymentField(
                        hint: _cvv,
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [_cvvMaskFormatter],
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: CinemaButton(
            isDisabled: false,
            title: _buttonText,
            onTap: () {
              _onOrder(context);
            },
          ),
        ),
      ],
    );
  }
}

class TextHint extends StatelessWidget {
  final String title;

  const TextHint({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

final _expirationDateMaskFormatter = MaskTextInputFormatter(
  mask: '##/##',
  type: MaskAutoCompletionType.lazy,
);

final _cvvMaskFormatter = MaskTextInputFormatter(
  mask: '###',
  filter: {"#": RegExp(r'\d')},
  type: MaskAutoCompletionType.lazy,
);

final _cardMaskFormatter = MaskTextInputFormatter(
  mask: '#### #### #### ####',
  filter: {"#": RegExp(r'\d')},
  type: MaskAutoCompletionType.lazy,
);
