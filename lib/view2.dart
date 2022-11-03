import 'package:flutter/material.dart';
import 'constants.dart';
import 'models.dart';

class SecondView extends StatefulWidget {
  final todoItemState toDoItem;

  const SecondView(this.toDoItem, {super.key});

  @override
  State<StatefulWidget> createState() {
    return SecondViewState(toDoItem);
  }
}

class SecondViewState extends State<SecondView> {
  late String title;
  late TextEditingController textEditingController;

  SecondViewState(todoItemState todoItem) {
    title = todoItem.title;
    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      setState(() {
        title = textEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          ),
          title: Center(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 30),
                child: const Text(
                  'Skriv todo-saker att lägga till här',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        body: _toDoinputbox());
    return MaterialApp(
      home: scaffold,
    );
  }

  _toDoinputbox() {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
        child: TextField(
          controller: textEditingController,
        ),
      ),
      Container(
        height: 35,
        width: 40,
      ),
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 39, 34, 34))),
          child: Text("Lägg till todo-sak"),
          onPressed: () {
            Navigator.pop(
                context, todoItemState(id: '', title: title, done: false));
          }),
    ]);
  }
}
