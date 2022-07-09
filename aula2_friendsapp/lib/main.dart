import 'package:flutter/material.dart';

void main() {
  runApp(const FriendsApp());
}

class FriendsApp extends StatelessWidget {
  const FriendsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Amigos',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meus Amigos'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyFriend('Stella'),
            MyFriend('Gabriel'),
            MyFriend('Anderson'),
            MyFriend('Camila'),
          ],
        )),
      ),
    );
  }
}

class MyFriend extends StatelessWidget {
  final String text;
  const MyFriend(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 30),
        ));
  }
}
