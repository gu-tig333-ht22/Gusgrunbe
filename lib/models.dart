import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'constants.dart';

class TodoState extends ChangeNotifier {
  final List<todoItemState> _list = [];
  List<todoItemState> get list => _list;

  String _filterBy = 'All';
  String get filterBy => _filterBy;

  TodoState() {
    _getTodos();
  }

  void _getTodos() async {
    http.Response reply = await http.get(Uri.parse('$url$key'));
    if (reply.statusCode == 200) {
      List<dynamic> data = jsonDecode(reply.body);
      _updateGetTodos(data);
      notifyListeners();
    }
  }

  void _updateGetTodos(List<dynamic> data) {
    _list.clear();
    for (var todo in data) {
      _list.add(todoItemState.fromJson(todo));
    }
  }

  void addTodo(todoItemState toDoItem) async {
    http.Response reply = await http.post(Uri.parse('$url$key'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toDoItem.toJson()));

    if (reply.statusCode == 200) {
      _list.add(toDoItem);
      notifyListeners();
      _updateGetTodos(jsonDecode(reply.body));
    }
  }

  void removeTodo(todoItemState toDoItem) async {
    http.Response reply = await http.delete(
        Uri.parse('$url/${toDoItem.id}$key'),
        headers: {'Content-Type': 'application/json'});

    if (reply.statusCode == 200) {
      _list.remove(toDoItem);
      notifyListeners();
      _updateGetTodos(jsonDecode(reply.body));
    }
  }

  void updateTodo(todoItemState toDoItem) async {
    toDoItem.todoItemDone(toDoItem);
    http.Response reply = await http.put(Uri.parse('$url/${toDoItem.id}$key'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toDoItem.toJson()));

    if (reply.statusCode == 200) {
      notifyListeners();
      _updateGetTodos(jsonDecode(reply.body));
    }
  }

  void filter(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
