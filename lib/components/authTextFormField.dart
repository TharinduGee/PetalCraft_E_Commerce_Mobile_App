import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  AuthTextFormField(
      {Key? key,
      required this.validator,
      this.obsecureText = false,
      required this.name,
      required this.controller})
      : super(key: key);

  final String? Function(String?) validator;
  final bool obsecureText;
  final String name;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      validator: validator,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF393939),
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: name,
        labelStyle: TextStyle(
          color: Color(0xFF755DC1),
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF837E93),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF9F7BFF),
          ),
        ),
      ),
    );
  }
}
