import 'package:flutter/material.dart';

InputDecoration decorationCampoTexto({String hintText = '', String labelText = ''}) {
  return InputDecoration(     
    /* enabledBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF2e8228), width: 0.0),      
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF2e8228), width: 0.0),      
    ),*/
    
      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF2e8228))),
      filled: true,
      // prefixIcon: Icon(Icons.person),
      hintText: hintText,
      labelText: labelText
      
      );
}
