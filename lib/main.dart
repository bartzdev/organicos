import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/unidade.dart';
import 'package:organicos/visao/certificadora/tela_pesquisa_certificadora.dart';
import 'package:organicos/visao/grupoprodutor/tela_cadastro_grupoprodutor.dart';
import 'package:organicos/visao/grupoprodutor/tela_pesquisa_grupoprodutos.dart';
import 'package:organicos/visao/permissao/chekbox_permissao.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/produtor/tela_pesquisa_produtor.dart';
import 'package:organicos/visao/relatorios/tela_relatorio_apres.dart';
import 'package:organicos/visao/relatorios/tela_relatorio_produtores.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/tela_principal.dart';
import 'package:organicos/visao/tipoProdutos/tela_pesquisa_tipoProduto.dart';
import 'package:organicos/visao/unidade/tela_cadastro_unidade.dart';
import 'package:organicos/visao/unidade/tela_pesquisa_unidade.dart';

import 'dao/produto_dao.dart';
import 'modelo/produto.dart';
import 'modelo/tipo_produto.dart';
import 'package:organicos/visao/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orgânicos',
      theme: temaGeralApp,
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      //   primaryColor: Color.fromRGBO(76, 175, 80, 1)      
      home: Login(), 
     //home: CheckboxWidget(),
/*
      home: Scaffold(
        appBar: AppBar(
        title: Text("Permissão Usuario"),
        ),
        body: SafeArea(
          child : Center(
 
          child:CheckboxWidget(),
   

    )
        )
      )*/
    );
    //TelaCadastroUnidade(ControleCadastros<Unidade>(Unidade()))
  }
}
