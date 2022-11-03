import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'constants.dart';

Widget _toDoItem(context, todoItemState toDoItem) {
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
