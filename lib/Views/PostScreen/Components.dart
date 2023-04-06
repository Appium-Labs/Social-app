import 'package:flutter/material.dart';

import '../../Constants.dart';

Widget primaryButton(String text) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    decoration: BoxDecoration(
        color: greenColor, borderRadius: BorderRadius.circular(10)),
    height: 50,
    child: Text(
      text,
      style: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          fontSize: 18),
    ),
  );
}

Widget TextInputField(String text, TextEditingController _controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins',
            color: secondaryTextColor,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 14),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: _controller,
        cursorColor: greenColor,
        maxLines: 10,
        minLines: 3,
        decoration: const InputDecoration(
          filled: true,
          fillColor: textFieldColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: textFieldColor, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: greenColor, width: 0.5),
          ),
        ),
      ),
    ],
  );
}
