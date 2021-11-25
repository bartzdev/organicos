import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/visao/login/loginControle.dart';
import 'package:organicos/visao/widgets/mensagens.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          
          child: Container(
            width: MediaQuery.of(context).size.width < 400? double.infinity: 400,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               TextField(
                autofocus: true,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: decorationCampoTexto(
                  labelText:"LOGIN",
                  //labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged:(textLogin){
                  loginEnt = textLogin;
                  

                } ,
           ) ,
            
              Divider(),
              TextField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: decorationCampoTexto(
                  labelText:"SENHA",
                  //labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (senhaLogin){
                  senhaEnt = senhaLogin;
                },
              ),
              Divider(),
              
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  
                  onPressed: () => {
                    
                    ValidaLogin().validacaoUser(loginEnt,senhaEnt),
                   },
                  shape: new RoundedRectangleBorder(borderRadius: 
new BorderRadius.circular(30.0)),
                  child: Text(
                    "ENTRAR",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  color:Colors.red,
                ),
              ),
            ],
         )
          ),
        ),
      )
   );
  }
}