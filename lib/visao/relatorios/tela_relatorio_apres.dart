import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class TelaRelatorio extends StatefulWidget{
    Uint8List? bites;
    TelaRelatorio({Key? key, this.bites}) : super(key: key);
    _TelaRelatorioStarte createState() => _TelaRelatorioStarte();
}

class _TelaRelatorioStarte extends State<TelaRelatorio>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatorio'),
        centerTitle: true,
      ),
      body: 
      widget.bites == null ? SizedBox() : 
       PdfPreview(
  build: (format) => widget.bites!,
    ));
  }
}