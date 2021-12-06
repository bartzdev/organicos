import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/visao/login/loginControle.dart';
import 'package:organicos/visao/widgets/mensagens.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

import '../tela_principal.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  String loginEnt = "";
  String senhaEnt = "";
  late Future<Usuario> userValidate;
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFF61b255),
        backgroundColor: Color(0xFFE1E1E1),
        body: SingleChildScrollView(child: Column (children: [Container( 
          width: MediaQuery.of(context).size.width,
          height: 300,
          color: Color(0xFF61b255),
          child: Image.asset('assets/imagens/logoOrganico.jpeg')
          
          
          ),
          SizedBox(height: 50),
           Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width < 400
                    ? double.infinity
                    : 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Color(0xFF1d1d1d), fontSize: 16),
                      decoration: decorationCampoTexto(
                        labelText: "LOGIN",
                        //labelStyle: TextStyle(color: Colors.white),
                      ),
                      cursorColor: Color(0xFF2e8228),
                      onChanged: (textLogin) {
                        loginEnt = textLogin;
                      },
                    ),
                    Divider(),
                    TextField(
                      autofocus: true,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Color(0XFF1d1d1d), fontSize: 16),
                      decoration: decorationCampoTexto(
                        labelText: "SENHA",
                        
                        //labelStyle: TextStyle(color: Colors.white),
                      ),
                      cursorColor: Color(0xFF2e8228),
                      onChanged: (senhaLogin) {
                        senhaEnt = senhaLogin;
                      },
                    ),
                    Divider(),
                    ButtonTheme(
                      height: 60.0,
                      child: InkWell(
                        onTap:  () async
                            {
                              if (loginEnt.trim().isEmpty || senhaEnt.trim().isEmpty){
                                mensagemAutenticacao(context, 'PREENCHA TODOS OS DADOS CORRETAMENTE', 'ATENÇÃO');

                              }else{                              
                                Usuario ?usuario = await ValidaLogin().validacaoUser(loginEnt, senhaEnt);
                                  if(usuario != null){
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TelaPrincipal()
                                  ));
                                  }else{
                                    mensagemAutenticacao(context, 'USUARIO NÃO ENCONTRADO', 'ATENÇÃO');
                                  }
                              }
                            },
                      child: Container(height: 50,
                       child: Card(
                       
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: Center(child:  Text(
                          "ENTRAR",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                        //color: Colors.red,
                        color: Color(0xFF2e8228),
                      )
                      ),
                    ),
                    )
                    ],
                )),
          ),
        )],)));
  }
}
