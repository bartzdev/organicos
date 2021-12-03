import 'package:flutter/material.dart';
import 'package:organicos/visao/login/loginControle.dart';

class TelaProdutor extends StatefulWidget {
  const TelaProdutor({Key? key}) : super(key: key);

  @override
  _TelaProdutorState createState() => _TelaProdutorState();
}

class _TelaProdutorState extends State<TelaProdutor> {
  @override
  Widget build(BuildContext context) {
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
                          labelText: 'Nome', border: OutlineInputBorder()),
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
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Cidade', border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (text) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Endereço', border: OutlineInputBorder()),
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
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[400],
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: Text('Cancelar')),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: Text('Continuar')),
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
              Text(
                  'Italo teste de alguma coisa colocada aqui dentro vamos ver'),
              ElevatedButton(
                onPressed: () {
                  print('Fui clicado');
                },
                child: Text('Nome do meu botão'),
              ),
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
              Text(
                  'Italo teste de alguma coisa colocada aqui dentro vamos ver'),
              ElevatedButton(
                onPressed: () {
                  print('Fui clicado');
                },
                child: Text('Nome do meu botão'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
