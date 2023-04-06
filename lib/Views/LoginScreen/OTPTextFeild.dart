import 'package:flutter/material.dart';

class OTPTextFeild extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;
  final TextEditingController thirdController;
  final TextEditingController fourthController;
  final TextEditingController fifthController;
  final TextEditingController sixthController;
  const OTPTextFeild(
      {super.key,
      required this.firstController,
      required this.secondController,
      required this.thirdController,
      required this.fourthController,
      required this.fifthController,
      required this.sixthController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: firstController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        const SizedBox(width: 17),
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: secondController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        const SizedBox(width: 17),
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: thirdController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        const SizedBox(width: 17),
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: fourthController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        const SizedBox(width: 17),
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: fifthController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        const SizedBox(width: 17),
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: sixthController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                // FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
      ],
    );
  }
}
