import 'package:flutter/cupertino.dart';

import 'vo_todo.dart';

class TodoDataNotifier extends ValueNotifier<List<Todo>> {
  TodoDataNotifier() : super([]);

  void addTodo(Todo todo) {
    // value는 List<Todo> 이고  ValueNotifier내부의 getter이다
    value.add(todo);

    // TodoDataNotifier class를 사용하는 주체들에 value가 변경됨을 알려준다.
    notifyListeners();
  }
}