import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contador',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Contador'),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ItemCounter('Flutter')],
          )),
        ));
  }
}

class ItemCounter extends StatefulWidget {
  final String name;
  const ItemCounter(this.name);

  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          count++;
        });
      },
      child:
          Text('${widget.name}: $count', style: const TextStyle(fontSize: 50)),
    );
  }
}
