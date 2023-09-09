import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todo_app/Model/todo.dart';
import 'package:todo_app/Provider/todoProvider.dart';

class Homepage extends StatelessWidget {
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final todos = ref.watch(todoProvider);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: todoController,
                  onFieldSubmitted: (value) {
                    final newTodo =
                        Todo(dateTime: DateTime.now().toString(), label: value);
                    ref.read(todoProvider.notifier).addTodo(newTodo);
                    todoController.clear();
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'Add some todo'),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(todo.label),
                        subtitle: Text(todo.dateTime),
                        trailing: Container(
                          width: 96,
                          child: Row(children: [
                            IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'edit',
                                      content: Container(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              initialValue: todo.label,
                                              onFieldSubmitted: (value) {
                                                final newTodo = Todo(
                                                    dateTime: todo.dateTime,
                                                    label: value);
                                                ref
                                                    .read(todoProvider.notifier)
                                                    .updateTodo(newTodo);
                                                todoController.clear();
                                                Navigator.of(context).pop();
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  hintText: 'Add some todo'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('close'))
                                          ],
                                        ),
                                      ));
                                },
                                icon: Icon(CupertinoIcons.pen)),
                            IconButton(
                                onPressed: () {
                                  ref
                                      .read(todoProvider.notifier)
                                      .removeTodo(todo);
                                },
                                icon: Icon(CupertinoIcons.delete)),
                          ]),
                        ),
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
