import 'package:flutter/material.dart';
import 'view2.dart';
import 'widgets.dart';

class todoItemState {
  String id;
  String title;
  bool done;

  todoItemState({
    required this.id,
    required this.title,
    this.done = false,
  });

  factory todoItemState.fromJson(Map<String, dynamic> json) {
    return todoItemState(
      title: json['title'],
      done: json['done'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
      'id': id,
    };
  }

  void todoItemDone(toDoItem) {
    done = !done;
  }
}
