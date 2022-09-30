import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes.dart';

class TodoList extends StatefulWidget {
  final List<TodoListState> filterList;

  const TodoList({required this.filterList});

  @override
  State<TodoList> createState() => _Buildlist();
}

class _Buildlist extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.filterList
            .map((todoItem) => _addTodoList(context, todoItem))
            .toList());
  }

  Widget _addTodoList(context, TodoListState todoItem) {
    var checkboxListTile = CheckboxListTile(
      contentPadding: const EdgeInsets.all(20.0),
      controlAffinity: ListTileControlAffinity.leading,
      value: todoItem.value,
      title: Text(todoItem.title,
          style: TextStyle(
              decoration: todoItem.value
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      secondary: IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          onPressed: () {
            Provider.of<TodoState>(context, listen: false).removeTodo(todoItem);
          }),
      onChanged: (value) => setState(
        () => todoItem.value = value!,
      ),
    );
    return checkboxListTile;
  }
}
