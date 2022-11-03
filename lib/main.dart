import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'todolist.dart';
import 'view2.dart';
import 'models.dart';

void main() {
  var state = TodoState();

  runApp(
    ChangeNotifierProvider(create: (context) => state, child: const TodoApp()),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: const ListView(title: 'Lägg till saker här nedanför'),
    );
  }
}

class ListView extends StatefulWidget {
  const ListView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListView> createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Todo list"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                onSelected: (String value) {
                  Provider.of<TodoState>(context, listen: false).filter(value);
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: 'All', child: Text('Visa alla')),
                      const PopupMenuItem(
                          value: 'Completed', child: Text('Visa klara')),
                      const PopupMenuItem(
                          value: 'Incomplete', child: Text('Visa inte klara'))
                    ]),
          ],
        ),
        body: Consumer<TodoState>(
            builder: (context, state, child) =>
                TodoList(filterList: _filterList(state.list, state.filterBy))),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: const Icon(
            Icons.add,
          ),
          onPressed: () async {
            var newToDo = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondView(todoItemState(
                          id: '',
                          title: '',
                          done: false,
                        ))));
            if (newToDo != null) {
              Provider.of<TodoState>(context, listen: false).addTodo(newToDo);
            }
          },
        ),
      );

  List<todoItemState> _filterList(List<todoItemState> list, String filterBy) {
    List<todoItemState> filteredList = [];
    filteredList.clear();

    if (filterBy == "Klar") {
      for (var element in list) {
        if (element.done == true) {
          filteredList.add(element);
        }
      }
      return filteredList;
    }

    if (filterBy == "Inte") {
      for (var element in list) {
        if (element.done == false) {
          filteredList.add(element);
        }
      }
      return filteredList;
    }
    return list;
  }
}
