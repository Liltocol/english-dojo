import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
            child: Column(children: <Widget>[
          ElevatedButton(
              child: const Text('問題取り込み'),
              onPressed: () {
                Navigator.of(context).pushNamed('/problem_import');
              }),
          ElevatedButton(
              child: const Text('問題を表示する'),
              onPressed: () {
                Navigator.of(context).pushNamed('/problem_view');
              }),
        ])));
  }
}
