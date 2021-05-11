import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final onChanged;
  final maxLength;
  final maxLines;
  final validator;
  final controller;
  final labelText;
  final inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization capitalization;
  final String? initialValue;

  const MyTextFormField({
    Key? key,
    this.maxLength,
    @required this.maxLines,
    this.validator,
    this.controller,
    this.labelText,
    this.inputFormatters,
    this.keyboardType,
    this.initialValue,
    required this.capitalization,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      textCapitalization: capitalization,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.text_format,
          color: Colors.black38,
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black54),
        contentPadding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        isDense: true,
        focusColor: Colors.black,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      inputFormatters: inputFormatters,
    );
  }
}
