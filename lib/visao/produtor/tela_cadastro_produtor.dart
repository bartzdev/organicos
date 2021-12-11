import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/certificadora.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/produtor/tela_pesquisa_certificadora_aqui.dart';
import 'package:organicos/visao/produtor/tela_pesquisa_grupoprodutor_aqui.dart';
import 'package:organicos/visao/widgets/mensagens.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaCadastroProdutor extends StatefulWidget {
  ControleCadastros<Produtor> controle;
  Function()? onSaved;

  TelaCadastroProdutor(this.controle, {Key? key, this.onSaved})
      : super(key: key);
  @override
  _TelaCadastroProdutor createState() => _TelaCadastroProdutor();
}

class _TelaCadastroProdutor extends State<TelaCadastroProdutor> {
  BuildContext? _context;
  ControleCadastros<Cidade> controleCidade = ControleCadastros(Cidade());
  var _chaveFormulario = GlobalKey<FormState>();
  Estado? _estadoSelecionado;

  Future<void> salvar(BuildContext context) async {
    if (_chaveFormulario.currentState != null &&
        _chaveFormulario.currentState!.validate()) {
      _chaveFormulario.currentState!.save();
      widget.controle.salvarObjetoCadastroEmEdicao().then((value) {
        if (widget.onSaved != null) widget.onSaved!();
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    int val = -1;
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.person),
                  child: MediaQuery.of(context).size.width < 400
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.person),
                            // SizedBox(
                            //   width: 10,
                            // ),

                            Expanded(
                                child: Center(
                                    child: Text(
                              'Dados do produtor',
                              textAlign: TextAlign.center,
                            ))),
                          ],
                        ),
                ),
                Tab(
                  icon: Icon(Icons.account_tree),
                  child: MediaQuery.of(context).size.width < 400
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.person),
                            // SizedBox(
                            //   width: 10,
                            // ),

                            Expanded(
                                child: Center(
                                    child: Text(
                              'Dados da propriedade',
                              textAlign: TextAlign.center,
                            ))),
                          ],
                        ),
                ),
                Tab(
                  icon: Icon(Icons.description),
                  child: MediaQuery.of(context).size.width < 400
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.person),
                            // SizedBox(
                            //   width: 10,
                            // ),

                            Expanded(
                                child: Center(
                                    child: Text(
                              'Dados da produção',
                              textAlign: TextAlign.center,
                            ))),
                          ],
                        ),
                ),
              ],
            ),
            title: Text('Tela Inicial'),
          ),
          body: TabBarView(
            children: [
              abaDadosPessoais(),
              abaDadosDoProprietario(),
              abaDadosDaPropriedade()
            ],
          ),
        ),
      ),
    );
  }

  Widget abaDadosPessoais() {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 30.0,
            runSpacing: 30.0,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Nome do produtor',
                            border: OutlineInputBorder()),
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao?.nome),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'CPF/CNPJ', border: OutlineInputBorder()),
                      initialValue:
                          widget.controle.objetoCadastroEmEdicao!.cpfCnpj,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaPesquisaCidades(
                                        onItemSelected: (Cidade cidade) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            widget
                                                .controle
                                                .objetoCadastroEmEdicao
                                                ?.endereco
                                                ?.cidade = cidade;
                                          });
                                        },
                                      )));
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                                key: Key((widget.controle.objetoCadastroEmEdicao
                                            ?.endereco?.cidade?.nome ==
                                        null
                                    ? ' '
                                    : widget.controle.objetoCadastroEmEdicao!
                                        .endereco!.cidade!.nome!)),
                                readOnly: true,
                                decoration: decorationCampoTexto(
                                    hintText: "Cidade", labelText: "Cidade"),
                                keyboardType: TextInputType.text,
                                initialValue: widget
                                    .controle
                                    .objetoCadastroEmEdicao
                                    ?.endereco
                                    ?.cidade
                                    ?.nome,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }))),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Endereço do produtor',
                            border: OutlineInputBorder()),
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao!.endereco ==
                                    null
                                ? ''
                                : widget.controle.objetoCadastroEmEdicao!
                                    .endereco!.logradouro),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                              onChanged: (text) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Número',
                                  border: OutlineInputBorder()),
                              initialValue:
                                  '${widget.controle.objetoCadastroEmEdicao!.endereco == null ? '' : widget.controle.objetoCadastroEmEdicao!.endereco!.numero}'),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: TextFormField(
                              onChanged: (text) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Bairro',
                                  border: OutlineInputBorder()),
                              initialValue: widget.controle
                                          .objetoCadastroEmEdicao!.endereco ==
                                      null
                                  ? ''
                                  : widget.controle.objetoCadastroEmEdicao!
                                      .endereco!.bairro),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Telefone',
                            border: OutlineInputBorder()),
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao!.telefone),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red[400],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 15
                                            : 20,
                                  )),
                              onPressed: () {},
                              child: Text('Cancelar')),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 15
                                            : 20,
                                  )),
                              onPressed: () {},
                              child: Text('Continuar →')),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget abaDadosDoProprietario() {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 30.0,
            runSpacing: 30.0,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Nome da propriedade',
                            border: OutlineInputBorder()),
                        initialValue: widget
                            .controle.objetoCadastroEmEdicao!.nomePropriedade),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text('Selecione abaixo a sua propriedade'),
                    ),
                    Center(
                        child: Image.asset(
                      'assets/imagens/google-maps.jpg',
                      height: 200,
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Latitude',
                          border: OutlineInputBorder(),
                          enabled: false,
                        ),
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao!.latitude),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Longitude',
                          border: OutlineInputBorder(),
                          enabled: false,
                        ),
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao!.longitude),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green[300],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 15
                                            : 20,
                                  )),
                              onPressed: () {},
                              child: Text('← Voltar')),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 15
                                            : 20,
                                  )),
                              onPressed: () {},
                              child: Text('Continuar →')),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[400],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 15
                                          : 20,
                                )),
                            onPressed: () {},
                            child: Text('Cancelar')),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget abaDadosDaPropriedade() {
    int result = 1;

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 30.0,
            runSpacing: 30.0,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TelaPesquisaCertificadoraAqui(
                                        onItemSelected:
                                            (Certificadora certificadora) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            widget
                                                .controle
                                                .objetoCadastroEmEdicao
                                                ?.certificadora = certificadora;
                                          });
                                        },
                                      )));
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                                key: Key((widget.controle.objetoCadastroEmEdicao
                                            ?.endereco?.cidade?.nome ==
                                        null
                                    ? ' '
                                    : widget.controle.objetoCadastroEmEdicao!
                                        .endereco!.cidade!.nome!)),
                                readOnly: true,
                                decoration: decorationCampoTexto(
                                    hintText: "Certificadoras",
                                    labelText: "Certificadoras"),
                                keyboardType: TextInputType.text,
                                initialValue: widget
                                    .controle
                                    .objetoCadastroEmEdicao
                                    ?.endereco
                                    ?.cidade
                                    ?.nome,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }))),
                    // TextFormField(
                    //     onChanged: (text) {},
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //         labelText: 'Certificadora',
                    //         border: OutlineInputBorder()),
                    //     initialValue: widget.controle.objetoCadastroEmEdicao!
                    //                 .certificadora ==
                    //             null
                    //         ? ''
                    //         : widget.controle.objetoCadastroEmEdicao!
                    //             .certificadora!.nome),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TelaPesquisaGrupoProdutorAqui(
                                        onItemSelected:
                                            (GrupoProdutor grupoProdutor) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            widget
                                                .controle
                                                .objetoCadastroEmEdicao
                                                ?.grupo = grupoProdutor;
                                          });
                                        },
                                      )));
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                                key: Key((widget.controle.objetoCadastroEmEdicao
                                            ?.endereco?.cidade?.nome ==
                                        null
                                    ? ' '
                                    : widget.controle.objetoCadastroEmEdicao!
                                        .endereco!.cidade!.nome!)),
                                readOnly: true,
                                decoration: decorationCampoTexto(
                                    hintText: "Grupo de produtores",
                                    labelText: "Grupo de produtores"),
                                keyboardType: TextInputType.text,
                                initialValue: widget
                                    .controle
                                    .objetoCadastroEmEdicao
                                    ?.endereco
                                    ?.cidade
                                    ?.nome,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }))),
                    // TextFormField(
                    //     onChanged: (text) {},
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //         labelText: 'Grupo de produtores',
                    //         border: OutlineInputBorder()),
                    //     initialValue:
                    //         widget.controle.objetoCadastroEmEdicao!.grupo ==
                    //                 null
                    //             ? ''
                    //             : widget.controle.objetoCadastroEmEdicao!.grupo!
                    //                 .nome),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Nome da propriedade',
                            border: OutlineInputBorder()),
                        initialValue: widget
                            .controle.objetoCadastroEmEdicao!.nomePropriedade),
                    SizedBox(
                      height: 30,
                    ),
                    // TextFormField(
                    //     onChanged: (text) {},
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //         labelText: 'Certificação orgânica',
                    //         border: OutlineInputBorder()),
                    //     initialValue: widget.controle.objetoCadastroEmEdicao!
                    //         .certificacaoOrganicos),
                    ListTile(
                      title: Text("Sim"),
                      leading: Radio(
                        value: 1,
                        groupValue: 'grupo1',
                        onChanged: (value) {
                          setState(() {});
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text("Não"),
                      leading: Radio(
                        value: 2,
                        groupValue: 'grupo1',
                        onChanged: (value) {
                          setState(() {
                            result;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green[300],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 15
                                            : 20,
                                  )),
                              onPressed: () {},
                              child: Text('← Voltar')),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 15
                                            : 20,
                                  )),
                              onPressed: () {
                                Salvar(context);
                              },
                              child: Text('Finalizar cadastro')),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[400],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 15
                                          : 20,
                                )),
                            onPressed: () {},
                            child: Text('Cancelar')),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> Salvar(BuildContext context) async {
    if (_chaveFormulario.currentState != null &&
        _chaveFormulario.currentState!.validate()) {
      _chaveFormulario.currentState!.save();
      widget.controle.salvarObjetoCadastroEmEdicao().then((value) {
        if (widget.onSaved != null) widget.onSaved!();
        Navigator.of(context).pop();
      }).catchError((error) {
        mensagemConexao(context);
      });
    }
  }
}
