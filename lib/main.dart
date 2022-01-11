import 'package:flutter/material.dart';
import 'package:snake_flutter/core/constant.dart';

import 'cell.dart';
import 'core/snake.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(x: snakeConfig["x"]!, y: snakeConfig["y"]!),
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

  @override
  initState() {
    super.initState();
    snakeInstance.start();
    snakeInstance.on("died", (res) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Game over"),
              // content: Text("您确定要删除当前文件吗?"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Play again"),
                  onPressed: () {
                    //关闭对话框并返回true
                    Navigator.of(context).pop(true);
                    snakeInstance.start();
                  },
                ),
              ],
            );
          });
    });
  }

  Widget mainBox() {
    return Center(
        child: GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        double dy = details.delta.dy;
        if (dy.abs() < 0.5) {
          return;
        }

        if (dy > 0) {
          snakeInstance.direction = Direction.bottom;
        }

        if (dy < 0) {
          snakeInstance.direction = Direction.top;
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        double dx = details.delta.dx;
        if (dx.abs() < 0.5) {
          return;
        }

        if (dx > 0) {
          snakeInstance.direction = Direction.right;
        }

        if (dx < 0) {
          snakeInstance.direction = Direction.left;
        }
      },
      child: Container(
        constraints: BoxConstraints.tightFor(
            width: border * widget.x + 2, height: border * widget.y + 2),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey.shade300),
            color: Colors.white),
        child: createGrides(),
      ),
    ));
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
