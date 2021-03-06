import 'package:flutter/material.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/login/loginControle.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaProdutor extends StatefulWidget {
  const TelaProdutor({Key? key}) : super(key: key);

  @override
  _TelaProdutorState createState() => _TelaProdutorState();
}

class _TelaProdutorState extends State<TelaProdutor> {
  BuildContext? _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
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
                              'Dados do proprietário',
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
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Nome do proprietário',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'CPF/CNPJ', border: OutlineInputBorder()),
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
                                            Text('Texto teste');
                                          });
                                        },
                                      )));
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                                readOnly: true,
                                decoration: decorationCampoTexto(
                                    hintText: "Cidade", labelText: "Cidade"),
                                keyboardType: TextInputType.text,
                                initialValue: '',
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }))),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Endereço do proprietário',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'CEP', border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (text) {},
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Número',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (text) {},
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Bairro',
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Telefone', border: OutlineInputBorder()),
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
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Nome da propriedade',
                          border: OutlineInputBorder()),
                    ),
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
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Latitude',
                        border: OutlineInputBorder(),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Longitude',
                        border: OutlineInputBorder(),
                        enabled: false,
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
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Certificadora',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Grupo de produtores',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Nome da propriedade',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Certificação orgânica',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
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
                              onPressed: () {},
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
}
