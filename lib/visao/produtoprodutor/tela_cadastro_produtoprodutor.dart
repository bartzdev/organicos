import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produtopontosvenda.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/modelo/produtor_produto.dart';
import 'package:organicos/visao/produtor/tela_pesquisa_produtor.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaCadastroProdutoProdutor extends StatefulWidget {
  @override
  _TelaCadastroProdutoProdutorState createState() =>
      _TelaCadastroProdutoProdutorState();
}

class _TelaCadastroProdutoProdutorState
    extends State<TelaCadastroProdutoProdutor> {
  ControleCadastros<Produtor> controle = ControleCadastros(Produtor());
  var _chaveFormulario = GlobalKey<FormState>();
  List<ProdutoPontosVenda> produtoPontos = [];

  void agruparProdutoPontos(List<ProdutorProduto> produtorProdutos) {
    for (ProdutorProduto prodPro in produtorProdutos) {
      bool achou = false;
      for (ProdutoPontosVenda pv in produtoPontos) {
        if (pv.produto!.id == prodPro.produto!.id) {
          pv.produtosPontoDeVenda.add(prodPro);
          achou = true;
        }
      }
      if (!achou) {
        ProdutoPontosVenda prodPonts = ProdutoPontosVenda();
        prodPonts.produto = prodPro.produto;
        prodPonts.produtosPontoDeVenda.add(prodPro);
        produtoPontos.add(prodPonts);
      }
    }
  }

  List<ProdutorProduto> desagruparProdutoPontos(
      List<ProdutoPontosVenda> produtoPontosVenda) {
    List<ProdutorProduto> retorno = [];

    for (ProdutoPontosVenda prodProFor in produtoPontosVenda) {
      for (ProdutorProduto pvFor in prodProFor.produtosPontoDeVenda) {
        retorno.add(pvFor);
      }
    }

    return retorno;
  }

  Widget cardProduto(ProdutoPontosVenda produtoPontosVenda, int index) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(produtoPontosVenda.produto?.nome == null
                ? ''
                : produtoPontosVenda.produto!.nome!)
          ]),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Future<void> salvar(BuildContext context) async {
    if (_chaveFormulario.currentState != null &&
        _chaveFormulario.currentState!.validate()) {
      _chaveFormulario.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cadastro de Ponto de Venda'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.check),
            onPressed: () {
              salvar(context);
            },
            label: const Text('Salvar')),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _chaveFormulario,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaPesquisaProdutor(
                                      onItemSelected:
                                          (Produtor produtor) async {
                                        Navigator.of(context).pop();
                                        controle.objetoCadastroEmEdicao =
                                            await controle
                                                .carregarDados(produtor);
                                        agruparProdutoPontos(controle
                                            .objetoCadastroEmEdicao!
                                            .produtosAVenda);
                                        setState(() {});
                                      },
                                    )));
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                              key: Key(
                                  (controle.objetoCadastroEmEdicao?.id == null
                                      ? ' '
                                      : controle.objetoCadastroEmEdicao!.id!
                                          .toString())),
                              readOnly: true,
                              decoration: decorationCampoTexto(
                                  hintText: "Produtor", labelText: "Produtor"),
                              keyboardType: TextInputType.text,
                              initialValue:
                                  controle.objetoCadastroEmEdicao?.nome,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Este campo é obrigatório!";
                                }
                                return null;
                              }))),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: produtoPontos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return cardProduto(produtoPontos[index], index);
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
