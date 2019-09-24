import 'package:flutter/material.dart';

import '../theme-provider.dart';

class TextFieldDecorated extends StatelessWidget {

  TextFieldDecorated({this.helperText, this.controller, this.validator, this.prefix = ""});

  final String helperText;
  final TextEditingController controller;
  final Function validator;
  final String prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
          borderRadius: const BorderRadius.all(
            const Radius.circular(5.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
          borderRadius: const BorderRadius.all(
            const Radius.circular(5.0),
          ),
        ),
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabled: true,
        filled: true,
        prefix: Text(prefix, style: TextStyle(fontSize: 20, color: ThemeProvider.grey1)),
        errorStyle: TextStyle(fontSize: 14, color: Colors.white),
      ),
      style: TextStyle(fontSize: 20, color: ThemeProvider.darkGrey),
      validator: (value)=> validator(value),
    );
  }
}
