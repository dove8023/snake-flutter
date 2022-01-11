/*
 * @Author: xisen.he 
 * @Date: 2022-01-07 14:48:03 
 * @Last Modified by: xisen.he
 * @Last Modified time: 2022-01-07 18:20:55
 */

import 'dart:async';

import './event.dart';
export './constant.dart' show Type;
import './constant.dart';

const Map<String, int> snakeConfig = {"x": 19, "y": 30};

class Snake extends Event {
  Snake(this.x, this.y);

  final int x;
  final int y;
  final List<Node> snakeBody = [];
  late Direction _direction = Direction.right;

  get direction {
    return _direction;
  }

  set direction(val) {
    if (val == _direction) {
      return;
    }

    if (val == Direction.top && _direction == Direction.bottom) {
      return;
    }

    if (val == Direction.bottom && _direction == Direction.top) {
      return;
    }

    if (val == Direction.left && _direction == Direction.right) {
      return;
    }

    if (val == Direction.right && _direction == Direction.left) {
      return;
    }

    _direction = val;
  }

  late Timer timer;

  create() {
    final Node head = Node(0, 0, Type.head);
    head.x = x ~/ 2;
    head.y = y ~/ 2;

    snakeBody.clear();
    snakeBody.add(head);
    snakeBody.insert(0, Node(head.x - 1, head.y, Type.body));
    snakeBody.insert(0, Node(head.x - 2, head.y, Type.body));
    snakeBody.insert(0, Node(head.x - 3, head.y, Type.body));
  }

  move() {
    final nextHead = next();
    if (nextHead.y < 1 || nextHead.y > y) {
      return died();
    }

    if (nextHead.x < 1 || nextHead.x > x) {
      return died();
    }

    snakeBody.add(nextHead);
    snakeBody.removeAt(0);

    snakeBody.forEach((element) {
      element.type = Type.body;
    });
    snakeBody.last.type = Type.head;

    emit("move", snakeBody);
  }

  Node next() {
    final Node head = snakeBody.last;
    final Node nextHead = Node(head.x, head.y, Type.head);

    switch (direction) {
      case Direction.top:
        nextHead.y--;
        break;
      case Direction.bottom:
        nextHead.y++;
        break;
      case Direction.left:
        nextHead.x--;
        break;
      case Direction.right:
        nextHead.x++;
        break;
      default:
        break;
    }

    return nextHead;
  }

  start() {
    create();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      move();
    });
  }

  died() {
    timer.cancel();
    emit("died", []);
  }
}

class Node {
  Node(this._x, this._y, this.type) {
    updateCellId();
  }

  updateCellId() {
    cellId = '$_x-$_y';
  }

  late int _x;
  late int _y;
  late String cellId;

  get x {
    return _x;
  }

  set x(val) {
    _x = val;
    updateCellId();
  }

  get y {
    return _y;
  }

  set y(val) {
    _y = val;
    updateCellId();
  }

  Type type;

  @override
  String toString() {
    super.toString();
    return '$x, $y, $type';
  }
}

final Snake snakeInstance = Snake(snakeConfig["x"]!, snakeConfig["y"]!);
