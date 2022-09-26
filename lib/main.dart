import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todoitemlist.dart';
import 'view.dart';
import 'classes.dart';

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
      debugShowCheckedModeBanner: false,
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
                  Provider.of<TodoState>(context, listen: false)
                      .filterTodo(value);
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
          backgroundColor: Color.fromARGB(255, 214, 112, 112),
          child: Icon(
            Icons.add_outlined,
          ),
          onPressed: () async {
            var newtask = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondView(TodoListState(
                          title: '',
                        ))));
            if (newtask != null) {
              Provider.of<TodoState>(context, listen: false).addTodo(newtask);
            }
          },
          hoverColor: Color.fromARGB(255, 107, 112, 182),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  List<TodoListState> _filterList(List<TodoListState> list, String filterBy) {
    List<TodoListState> filteredList = [];
    filteredList.clear();

    if (filterBy == "Completed") {
      list.forEach((TodoListState element) {
        if (element.value == true) {
          filteredList.add(element);
        }
      });
      return filteredList;
    }

    if (filterBy == "Incompleted") {
      for (var element in list) {
        if (element.value == false) {
          filteredList.add(element);
        }
      }
      return filteredList;
    }
    return list;
  }
}
