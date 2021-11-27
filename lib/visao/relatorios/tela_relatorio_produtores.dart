import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GerarPDF {
  List<Produtor>? produtores = [];
  GerarPDF({@required this.produtores});

  Future<Uint8List> gerearPDFProdutores() async {
    final pw.Document doc = pw.Document();
    pw.Widget _buildHeader(pw.Context context) {
      return pw.Container(
          color: PdfColors.blue,
          height: 150,
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                      ),
                      pw.Text('Produtores Organicos',
                          style: pw.TextStyle(
                              fontSize: 25, color: PdfColors.white))
                    ]),
              ]));
    }

    pw.Widget _buildFooter(pw.Context context){
      return pw.Container(
        color: PdfColors.blue,
        height: 130,
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 12),
              child: pw.Text('App desenvolvido pela turma de TADS do IFPR de Assis Chateabriand, PR e mantido pela equipe da UNIOESTE de Toledo, PR')
            )
          ]
        )
      );
    }

    String _getValueIndex(Produtor produtor, int col){
      switch (col){
        case 0:
          return produtor.nome!;
        case 1:
          return produtor.endereco!.cidade!.nome!;
      }
      return '';
    }

    pw.Widget _contentTable(pw.Context context){
      const tableHeaders = ['Nome Produtor', 'Cidade'];
      return pw.Table.fromTextArray(
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: pw.BoxDecoration(
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        ),
        headerHeight: 25,
        cellHeight: 40,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(
          fontSize: 10,
          color: PdfColors.blue,
          fontWeight: pw.FontWeight.bold
        ),
        cellStyle: const pw.TextStyle(fontSize: 10),
        rowDecoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.blue,
            width: 0.5
          ),
        ),
        headers: tableHeaders,
        data: List<List<String>>.generate(
          produtores!.length,
          (row) => List<String>.generate(
            tableHeaders.length,
            (col) => _getValueIndex(produtores![row], col)
          )
        ));
    }

    List<pw.Widget> _buildContent(pw.Context context){
      return [];
    }

  doc.addPage(pw.MultiPage(
    pageTheme: pw.PageTheme(margin: pw.EdgeInsets.zero),
    header: _buildHeader,
    footer: _buildFooter,
    build: (context) => _buildContent(context)
    ));

    return await doc.save();
  }
}

class TelaGerarRelatorio extends StatefulWidget{
  

  TelaGerarRelatorio({Key? key}) : super(key: key);
  _TelaGerarRelatorioState createState() => _TelaGerarRelatorioState();
}

class _TelaGerarRelatorioState extends State<TelaGerarRelatorio>{
 Uint8List? bites;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('GerarPdf'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            Produtor produtor = Produtor();
            produtor.id = 1;
            produtor.nome = 'Luiz';
            Cidade cidade = Cidade();
            cidade.id = 1;
            cidade.nome = 'Jesuitas';
            Estado estado = Estado();
            estado.id = 1;
            estado.nome = 'Parana';
            estado.sigla = 'PR';
            cidade.estado = estado;
            produtor.endereco?.cidade = cidade;
          List<Produtor>? produtores;
          produtores?.add(produtor);
          GerarPDF gerarPDF = GerarPDF(produtores: produtores);
          bites = await gerarPDF.gerearPDFProdutores();
          setState(() {
            
          });
        },
        child: Icon(Icons.print),
      ),
      body:
      bites == null ? SizedBox() : 
       PdfPreview(
  build: (format) => bites!,
),
    );
}
}