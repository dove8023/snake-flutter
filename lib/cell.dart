import 'package:flutter/material.dart';

import './core/snake.dart';

class CellWidget extends StatefulWidget {
  const CellWidget({Key? key, required this.id}) : super(key: key);
  final String id;
  final Type type = Type.blank;

  @override
  State<StatefulWidget> createState() => Cell();
}

class Cell extends State<CellWidget> {
  Color? color;

  @override
  initState() {
    super.initState();

    snakeInstance.on("move", (List<Node> snakeBody) {
      Node? target;
      final res = snakeBody.any((element) {
        if (element.cellId == widget.id) {
          target = element;
          return true;
        }

        return false;
      });

      setState(() {
        color = res ? display(target!.type) : display(Type.blank);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      constraints: const BoxConstraints.tightFor(width: 20.0, height: 20.0),
      decoration: const BoxDecoration(
          border: Border(
              right: BorderSide(color: Colors.black45, width: 1.0),
              bottom: BorderSide(color: Colors.black45, width: 1.0))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: color),
      ),
    );
  }

  Color? display(Type type) {
    Color? color;
    switch (type) {
      case Type.blank:
        color = null;
        break;
      case Type.head:
        color = Colors.amber.shade800;
        break;
      case Type.body:
        color = Colors.yellow.shade400;
        break;
      case Type.food:
        color = Colors.blue.shade300;
    }

    return color;
  }
}
