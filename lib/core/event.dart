/*
 * @Author: xisen.he 
 * @Date: 2022-01-07 15:06:22 
 * @Last Modified by: xisen.he
 * @Last Modified time: 2022-01-07 16:03:55
 */

class Event {
  final store = <String, List<Function>>{};

  on(String eventName, Function callback) {
    if (!store.keys.contains(eventName)) {
      store[eventName] = [];
    }
  }

  emit(String eventName, String type) {
    var callbacks = store[eventName];
    if (callbacks == null || callbacks.isEmpty) {
      return;
    }

    callbacks.map((e) => e(type));
  }
}
