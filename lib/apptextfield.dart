import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// We refactor the code in a separate class. This is to ensure the code is reusable, readable and maintainable.

class AppTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final keyboardType;
  final int? maxNum;
  final maxLengthEnforcement;
  final bool obscureText;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final AutovalidateMode autovalidateMode;
  final TextInputAction? textInputAction;

  AppTextField(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.labelText,
      this.maxNum,
      this.maxLengthEnforcement,
      required this.obscureText,
      required this.autocorrect,
      required this.textCapitalization,
      this.validator,
      this.onSaved,
      required this.autovalidateMode,
      required this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
        maxLength: maxNum,
        maxLengthEnforcement: maxLengthEnforcement,
        obscureText: obscureText,
        autocorrect: autocorrect,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        validator: validator,
        onSaved: onSaved,
        autovalidateMode: autovalidateMode,
        textInputAction: textInputAction,
      ),
    );
  }
}
