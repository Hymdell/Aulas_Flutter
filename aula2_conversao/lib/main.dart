import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const Home(),
        theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.white));
  }
}

Future<Map> getData() async {
  var request =
      Uri.parse('https://api.hgbrasil.com/finance?format=json&key=e0852aae');

  http.Response response = await http.get(request);
  print(json.decode(response.body));

  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  late double dolar;
  late double euro;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    dolarController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    dolarController.text = (euro * this.euro).toStringAsFixed(2);
    euroController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Conversor de moeda'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: Text(
                      'Aguarde . . .',
                      style: TextStyle(color: Colors.green, fontSize: 30.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      'Ops, houve uma falha ao buscar os dados',
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar =
                        snapshot.data!['results']['currencies']['USD']['buy'];
                    euro =
                        snapshot.data!['results']['currencies']['EUR']['buy'];

                    return SingleChildScrollView(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Icon(
                              Icons.attach_money,
                              size: 100,
                              color: Colors.green,
                            ),
                            buildTextField(
                                'Reais', 'R\$ ', realController, _realChanged),
                            const Divider(),
                            buildTextField(
                                'Euros', '€ ', euroController, _euroChanged),
                            const Divider(),
                            buildTextField('Dólares', 'US\$ ', dolarController,
                                _dolarChanged),
                            const Divider(),
                          ],
                        ));
                  }
              }
            }));
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function(String) f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: const OutlineInputBorder(),
        prefixText: prefix),
    style: const TextStyle(color: Colors.green, fontSize: 25.0),
    onChanged: f,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}
