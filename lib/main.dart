import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      fontStyle: FontStyle.normal,
      color: Colors.black54,
      fontSize: 16.0,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      trailing: Icon(Icons.delete),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    var floatingActionButton;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo list TIG169'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          children: _todos.map((Todo todo) {
            return TodoItem(
              todo: todo,
              onTodoChanged: _handleTodoChange,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_forward_ios),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondView()))),
        backgroundColor: Color.fromARGB(255, 214, 219, 218),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(null),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'LÄGG TILL I LISTAN',
            ),
          ],
          onTap: (ValueKey) => _displayDialog(),
          backgroundColor: Color.fromARGB(255, 236, 230, 215),
        ));
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

// create a function so that items can be removed from the list by pressing the delete button

  void _removeTodoItem(Todo todo) {
    setState(() {
      _todos.remove(todo);
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Skriv något att göra'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Skriv nästa att-göra'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Lägg till'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo list',
      home: new TodoList(),
    );
  }
}

class SecondView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hämta info från nätet")),
      body: const Center(),
    );
  }
}

void main() => runApp(new TodoApp());
