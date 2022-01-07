/*
 * @Author: xisen.he 
 * @Date: 2022-01-07 14:48:03 
 * @Last Modified by: xisen.he
 * @Last Modified time: 2022-01-07 18:20:55
 */

import './event.dart';
export './constant.dart' show Type;
import './constant.dart';

class Snake extends Event {
  Snake(this.x, this.y) {
    create();
  }

  final int x;
  final int y;
  final List snakeBody = [];
  Direction direction = Direction.right;

  create() {
    final Node head = Node(0, 0, Type.head);
    head.x = x ~/ 2;
    head.y = y ~/ 2;
    head.cellId = '${head.x}-${head.y}';

    snakeBody.add(head);
    snakeBody.add(Node(head.x - 1, head.y, Type.body));
    snakeBody.add(Node(head.x - 2, head.y, Type.body));
    snakeBody.add(Node(head.x - 3, head.y, Type.body));
  }
}

class Node {
  Node(this.x, this.y, this.type) {
    cellId = '$x-$y';
  }

  int x;
  int y;

  late String cellId;
  Type type;
}

void main() {
  var snake = Snake(100, 100);

  snake.snakeBody.forEach((e) {
    print('${e.x}, ${e.y}, ${e.cellId}');
  });

  snake.on("good", () {});

  print(snake.store);
}
