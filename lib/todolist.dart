import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'constants.dart';

class TodoList extends StatefulWidget {
  final List<todoItemState> filterList;

  const TodoList({super.key, required this.filterList});

  @override
  State<TodoList> createState() => _CreateListState();
}

class _CreateListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.filterList
            .map((toDoItem) => _addTodoItem(context, toDoItem))
            .toList());
  }

  Widget _addTodoItem(context, todoItemState toDoItem) {
    var checkbox = CheckboxListTile(
      value: toDoItem.done,
      title: Text(toDoItem.title,
          style: TextStyle(
              decoration: toDoItem.done
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      secondary: IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          onPressed: () {
            Provider.of<TodoState>(context, listen: false).removeTodo(toDoItem);
          }),
      onChanged: (bool? value) {
        Provider.of<TodoState>(context, listen: false).updateTodo(toDoItem);
      },
    );
    return checkbox;
  }
}
