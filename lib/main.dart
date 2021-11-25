import 'package:flutter/material.dart';
import 'package:organicos/visao/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(      
      home: Login(),    
    );
  }
}
