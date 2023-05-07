import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String _hint = "Phone number";

class OtpForm extends StatelessWidget {
  final bool showOtp;
  final TextEditingController phoneController;
  final TextEditingController otpController;
  final ValueChanged<String> onPhoneSubmitted;
  final ValueChanged<String> onOtpSubmitted;

  const OtpForm({
    Key? key,
    required this.showOtp,
    required this.onPhoneSubmitted,
    required this.onOtpSubmitted,
    required this.phoneController,
    required this.otpController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300.0,
            child: TextField(
              controller: phoneController,
              onSubmitted: onPhoneSubmitted,
              decoration: const InputDecoration(
                labelText: _hint,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 18.0,
                ),
              ),
              keyboardType: TextInputType.phone,
              enabled: !showOtp,
            ),
          ),
          const SizedBox(height: 20.0,),
          if (showOtp)
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: otpController,
                onSubmitted: onOtpSubmitted,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 18.0,
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d')),
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
            )
        ],
      ),
    );
  }
}
