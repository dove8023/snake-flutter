import 'package:flutter/material.dart';

import 'cell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(x: 20, y: 30),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.x, required this.y})
      : super(key: key);

  final int x;
  final int y;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const double border = 20.0;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return mainBox();
  }

  Widget mainBox() {
    return Center(
      child: Container(
        constraints: BoxConstraints.tightFor(
            width: border * widget.x + 2, height: border * widget.y + 2),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey.shade300),
        ),
        child: createGrides(),
      ),
    );
  }

  createGrides() {
    final x = widget.x;
    final y = widget.y;

    List<Widget> cols = [];

    for (int i = 1; i <= y; i++) {
      List<Widget> rows = [];

      for (int j = 1; j <= x; j++) {
        rows.add(CellWidget(id: '$j-$i'));
      }

      cols.add(Row(
        children: rows,
      ));
    }

    return Column(
      children: cols,
    );
  }
}
