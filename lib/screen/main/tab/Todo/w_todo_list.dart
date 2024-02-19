import 'package:app_base/common/common.dart';
import 'package:app_base/data/memory/todo_data_holder.dart';
import 'package:flutter/material.dart';

import 'w_todo_item.dart';

/// TodoList에 추가되어 화면에 나타나는데 이때 상태변화(setState)는 TodoDataNotifier에서 해주기
/// 때문에 별도로 상태변화에 대한 처리를 해줄 필요가 없다(StatelessWidget)
class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TodoDataHolder.of(context).notifier,
      // todoList : notifier.value
      builder: (context, todoList, child) {
        return todoList.isEmpty
            ? '할일을 작성해 보세요'.text.size(30).makeCentered()
            : Column(children: todoList.map((e) => TodoItem(e)).toList(),);
      },
    );
  }
}
