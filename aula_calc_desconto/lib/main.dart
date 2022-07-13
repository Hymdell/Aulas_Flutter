import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Desconto',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var initValueController = TextEditingController();
  var discountController = TextEditingController();
  var percentualController = TextEditingController();
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desconto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Divider(),
            Text(
              result.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Divider(),
            buildTextField('Valor Inicial', initValueController),
            const Divider(),
            buildTextField('Valor Desconto', discountController),
            const Divider(),
            buildTextField('Percentual', percentualController),
            const Divider(),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    result = calcularDesconto(
                      double.parse(initValueController.text),
                      double.parse(discountController.text),
                      int.parse(percentualController.text),
                    );
                  });
                },
                child: const Text(
                  'Calcular',
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController c) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue),
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(color: Colors.blue, fontSize: 25.0),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

  double calcularDesconto(double initValue, double discount, int percentual) {
    if (discount <= 0) {
      throw ArgumentError('O desconto deve ser maior que zero!');
    }
    if (initValue <= 0) {
      throw ArgumentError('O valor inicial deve ser maior que zero!');
    }
    if (percentual != 0) {
      return initValue - (initValue * discount / 100);
    }
    return initValue - discount;
  }
}
