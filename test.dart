// import 'dart:async';

// void main() {
//   int count = 0;
//   final timer = Timer.periodic(Duration(seconds: 1), (timer) {
//     print(count++);

//     if (count > 10) {
//       timer.cancel();
//     }
//   });
// }

void main() {
  List arr = [11, 22, 33, 44, 55];

  final a = arr.any((element) => element == 22);
  arr.forEach((e) {
    print(e);
  });

  print(arr);
  print(a);
}
