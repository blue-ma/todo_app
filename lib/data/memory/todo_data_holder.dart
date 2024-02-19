import 'package:app_base/data/memory/todo_data_notifier.dart';
import 'package:flutter/cupertino.dart';

import 'todo_data_notifier.dart';

class TodoDataHolder extends InheritedWidget {
  final TodoDataNotifier notifier;

  const TodoDataHolder({super.key, required super.child, required this.notifier, });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw true;
  }

  static TodoDataHolder of(BuildContext context) {
    TodoDataHolder inherited = (context.dependOnInheritedWidgetOfExactType<TodoDataHolder>())!;
    return inherited;
  }
}