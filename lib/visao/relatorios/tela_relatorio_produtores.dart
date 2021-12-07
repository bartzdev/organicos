import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/relatorios/tela_relatorio_apres.dart';
import 'package:organicos/visao/widgets/textformfield.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GerarPDF {
  List<Produtor>? produtores = [];
  GerarPDF({@required this.produtores});

  Future<Uint8List> gerearPDFProdutores() async {
    final pw.Document doc = pw.Document();
    ByteData imagemByte =
        await rootBundle.load('assets/imagens/logoOrganico.jpeg');
    Uint8List imagem = imagemByte.buffer.asUint8List();
    pw.Widget _buildHeader(pw.Context context) {
      return pw.Container(
          color: PdfColor.fromHex('61b255'),
          height: 100,
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.only(left: 20),
                        child: 
                       pw.Text('Produtores',
                            style: pw.TextStyle(
                                fontSize: 25, color: PdfColors.white)),
                      ),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(left: 300),
                          child: pw.Image(pw.MemoryImage((imagem))))
                    ]),
              ]));
    }

    pw.Widget _buildFooter(pw.Context context) {
      return pw.Container(
          color: PdfColor.fromHex('61b255'),
          height: 100,
          width: 700,
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Padding(
                    padding: pw.EdgeInsets.only(top: 35),
                    child: pw.Text(
                        'App desenvolvido pelo TADS turma de 2019 do IFPR de Assis Chateabriand, PR',
                        style: pw.TextStyle(color: PdfColors.white))),
                pw.Padding(
                    padding: pw.EdgeInsets.only(bottom: 35),
                    child: pw.Text(
                        'e mantido pela equipe da UNIOESTE de Toledo, PR',
                        style: pw.TextStyle(color: PdfColors.white)))
              ]));
    }

    String _getValueIndex(Produtor produtor, int col) {
      switch (col) {
        case 0:
          return produtor.nome!;
        case 1:
          return produtor.endereco!.cidade!.nome!;
        case 2:
          return produtor.endereco!.cidade!.estado!.sigla!;
        case 3:
          return produtor.telefone!;
      }
      return '';
    }

    pw.Widget _contentTable(pw.Context context) {
      const tableHeaders = ['Nome Produtor', 'Cidade', 'Estado', 'Telefone'];
      return pw.Table.fromTextArray(
          cellAlignment: pw.Alignment.centerLeft,
          headerDecoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
          ),
          headerHeight: 25,
          cellHeight: 40,
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerLeft,
            2: pw.Alignment.centerLeft,
            3: pw.Alignment.centerLeft

          },
          headerStyle: pw.TextStyle(
              fontSize: 10,
              color: PdfColor.fromHex('61b255'),
              fontWeight: pw.FontWeight.bold),
          cellStyle: const pw.TextStyle(fontSize: 10),
          rowDecoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.green, width: 0.5),
          ),
          headers: tableHeaders,
          data: List<List<String>>.generate(
              produtores!.length,
              (row) => List<String>.generate(tableHeaders.length,
                  (col) => _getValueIndex(produtores![row], col))));
    }

    List<pw.Widget> _buildContent(pw.Context context) {
      return [
        pw.Padding(
            padding: pw.EdgeInsets.only(top: 50, left: 25, right: 25),
            child: _contentTable(context))
      ];
    }

    doc.addPage(pw.MultiPage(
        pageTheme: pw.PageTheme(margin: pw.EdgeInsets.zero),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => _buildContent(context)));

    return await doc.save();
  }
}

class TelaGerarRelatorio extends StatefulWidget {
  TelaGerarRelatorio({Key? key}) : super(key: key);
  _TelaGerarRelatorioState createState() => _TelaGerarRelatorioState();
}

class _TelaGerarRelatorioState extends State<TelaGerarRelatorio> {
  Uint8List? bites;
  @override
  Widget build(BuildContext context) {
    Cidade CidadeFiltro = Cidade();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('GerarPdf'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Produtor produtor = Produtor();
          produtor.id = 1;
          produtor.nome = 'Luiz Elizandro de Oliveira';
          produtor.telefone = '(44) 99999-9999';
          Endereco endereco = Endereco();
          endereco.bairro = 'centro';
          Cidade cidade = Cidade();
          cidade.id = 1;
          cidade.nome = 'Jesuitas';
          Estado estado = Estado();
          estado.id = 1;
          estado.nome = 'Parana';
          estado.sigla = 'PR';
          cidade.estado = estado;
          endereco.cidade = cidade;

          produtor.endereco = endereco;
          List<Produtor> produtores = [];
          produtores.add(produtor);
          GerarPDF gerarPDF = GerarPDF(produtores: produtores);
          bites = await gerarPDF.gerearPDFProdutores();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaRelatorio(
                        bites: bites,
                      )));
        },
        child: Icon(Icons.print),
      ),
        body: 
                    GestureDetector(
                        onTap: () {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => TelaPesquisaCidades(
                                         onItemSelected: (Cidade cidade) {
                                           Navigator.of(context).pop();
                                           setState(() {
                                             CidadeFiltro.nome = cidade.nome;
                                           });
                                         },
                                       )));
                        },
                        child: AbsorbPointer(
                             child: TextFormField(
                                 key: Key((CidadeFiltro.nome ==
                                         null
                                     ? ' '
                                     : CidadeFiltro.nome!)),
                                 readOnly: true,
                                 decoration: decorationCampoTexto(
                                     hintText: "Cidade", labelText: "Cidade"),
                                 keyboardType: TextInputType.text,
                                 initialValue: CidadeFiltro.nome,
                                 validator: (value) {
                                   if (value == null || value.trim().isEmpty) {
                                     return "Este campo é obrigatório!";
                                   }
                                   return null;
                                 }))
                                ),
      );
  }
}
