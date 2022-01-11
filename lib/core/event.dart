/*
 * @Author: xisen.he 
 * @Date: 2022-01-07 15:06:22 
 * @Last Modified by: xisen.he
 * @Last Modified time: 2022-01-07 16:03:55
 */

class Event {
  final Map<String, List<Function>> store = {};

  on(String eventName, Function callback) {
    if (!store.keys.contains(eventName)) {
      store[eventName] = [];
    }

    store[eventName]!.add(callback);
  }

  emit(String eventName, List? arr) {
    final List? callbacks = store[eventName];
    if (callbacks == null) {
      return;
    }

    for (int i = 0; i < callbacks.length; i++) {
      callbacks[i](arr);
    }
  }
}
