import 'package:flutter/material.dart';

class TodoState extends ChangeNotifier {
  final List<TodoListState> _list = [];

  String nyckel = "391016ed-e7f4-46be-85dc-2a612623cc9e";
  String hemsida = "https://todoapp-api.apps.k8s.gu.se/todos";

  List<TodoListState> get list => _list;

  String _filterBy = 'All';
  String get filterBy => _filterBy;

  void removeTodo(TodoListState todoItem) {
    _list.remove(todoItem);
    notifyListeners();
  }

  void addTodo(TodoListState todoItem) {
    _list.add(todoItem);
    notifyListeners();
  }

  void filterTodo(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}

class TodoListState {
  final String title;
  bool value;

  TodoListState({
    required this.title,
    this.value = false,
  });
}
