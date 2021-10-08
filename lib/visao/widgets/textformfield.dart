import 'package:flutter/material.dart';

InputDecoration decorationCampoTexto({String hintText = '', String labelText = ''}) {
  return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
      filled: true,
      // prefixIcon: Icon(Icons.person),
      hintText: hintText,
      labelText: labelText);
}
