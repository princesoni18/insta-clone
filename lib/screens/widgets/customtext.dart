
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String hintText;
  final bool pass;
  CustomTextField(
      {super.key,
      required this.hintText,
      this.pass = false,
      required this.textEditingController,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final InputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder,
          focusedBorder: InputBorder,
          enabledBorder: InputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: pass,
    );
  }
}
