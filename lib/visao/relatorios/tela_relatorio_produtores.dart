import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/dao/relatorios_dao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/utilitarios.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/relatorios/tela_relatorio_apres.dart';
import 'package:organicos/visao/styles/styles.dart';
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

    ByteData imagemByte2 =
        await rootBundle.load('assets/imagens/assis-horizontal-menor.png');
    Uint8List imagemRodape = imagemByte2.buffer.asUint8List();
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
                        child: pw.Text('Produtores',
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
                    padding: pw.EdgeInsets.only(top: 20),
                    child: pw.Image(pw.MemoryImage(imagemRodape)))
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
          return formataTelefone(produtor.telefone)!;
        case 4:
          return produtor.certificadora == null
              ? ''
              : produtor.certificadora!.nome!;
      }
      return '';
    }

    pw.Widget _contentTable(pw.Context context) {
      const tableHeaders = [
        'Nome Produtor',
        'Cidade',
        'Estado',
        'Telefone',
        'Certificadora'
      ];
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
            3: pw.Alignment.centerLeft,
            4: pw.Alignment.centerLeft
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
  Cidade? CidadeFiltro;
  String certificado = 't';
  int grupo = 1;
  TipoProduto? filtroTipo;

  ControleCadastros<TipoProduto> controleTipoProduto =
      ControleCadastros(TipoProduto());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text('GerarPdf'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            List<Produtor> produtores = [];
            RelatorioDAO dao = RelatorioDAO();
            print(CidadeFiltro?.id);
            produtores = await dao.pesquisarProdutoCidade(filtros: {
              'Cidade': CidadeFiltro?.id,
              'Certificado': certificado,
              'Tipo': filtroTipo
            });
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
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8, top: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 80,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaPesquisaCidades(
                                            onItemSelected: (Cidade cidade) {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                CidadeFiltro = cidade;
                                              });
                                            },
                                          )));
                            },
                            child: AbsorbPointer(
                                child: TextFormField(
                                    key: Key((CidadeFiltro == null
                                        ? ' '
                                        : CidadeFiltro!.nome!)),
                                    readOnly: true,
                                    decoration: decorationCampoTexto(
                                        hintText: "Cidade",
                                        labelText: "Cidade"),
                                    keyboardType: TextInputType.text,
                                    initialValue: CidadeFiltro?.nome,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Este campo ?? obrigat??rio!";
                                      }
                                      return null;
                                    }))),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            CidadeFiltro = null;
                          });
                        },
                        child: Image.asset('assets/imagens/clean.png',
                            height: 50, width: 50),
                      ),
                    ],
                  ),
                )
              ],
            ),
            espacoEntreCampos,
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Radio<int>(
                    value: 1,
                    groupValue: grupo,
                    onChanged: (int? value) {
                      setState(() {
                        grupo = 1;
                      });
                      certificado = 'c';
                    },
                  ),
                  Text(
                    'Com certificado',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio<int>(
                      value: 2,
                      groupValue: grupo,
                      onChanged: (int? value) {
                        setState(() {
                          grupo = 2;
                        });
                        certificado = 's';
                      }),
                  Text(
                    'Sem certificado',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Radio<int>(
                      value: 3,
                      groupValue: grupo,
                      onChanged: (int? value) {
                        setState(() {
                          grupo = 3;
                        });
                        certificado = 't';
                      }),
                  Text(
                    'Todos',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            espacoEntreCampos,
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: FutureBuilder(
                        future: controleTipoProduto.listar(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          String labelCampo = "Tipo";
                          if (!snapshot.hasData) {
                            labelCampo = "Carregando tipo do produto...";
                          } else {
                            controleTipoProduto.listaObjetosPesquisados =
                                snapshot.data as List<TipoProduto>;
                          }
                          return DropdownButtonFormField<TipoProduto>(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                                filled: true,
                                isDense: true,
                                hintText: labelCampo,
                                labelText: labelCampo),
                            isExpanded: true,
                            items: controleTipoProduto
                                        .listaObjetosPesquisados ==
                                    null
                                ? []
                                : controleTipoProduto.listaObjetosPesquisados!
                                    .map<DropdownMenuItem<TipoProduto>>(
                                        (TipoProduto tipoProduto) {
                                    return DropdownMenuItem<TipoProduto>(
                                      value: tipoProduto,
                                      child: Text(tipoProduto.nome!,
                                          textAlign: TextAlign.center),
                                    );
                                  }).toList(),
                            value: filtroTipo,
                            validator: (value) {
                              if (value == null) {
                                return "Campo Obrigat??rio!";
                              }
                              return null;
                            },
                            onChanged: (TipoProduto? value) {
                              setState(() {
                                filtroTipo = value;
                              });
                            },
                          );
                        }),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      filtroTipo = null;
                    });
                  },
                  child: Image.asset('assets/imagens/clean.png',
                      height: 50, width: 50),
                ),
                espacoEntreCampos,
              ],
            )
          ],
        ));
  }
}
