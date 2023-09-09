import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Model/todo.dart';

final List<Todo> todos = [
  Todo(dateTime: '${DateTime.now()}', label: 'Reading abook'),
  Todo(dateTime: '${DateTime.now()}', label: 'Watching movie'),
];
final todoProvider = StateNotifierProvider<TodoProvider, List<Todo>>(
    (ref) => TodoProvider(todos));

class TodoProvider extends StateNotifier<List<Todo>> {
  TodoProvider(super.state);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(Todo todo) {
    state.remove(todo);
    state = [...state];
  }

  void updateTodo(Todo newTodo) {
    state = [
      for (final m in state) m.dateTime==newTodo.dateTime?newTodo:m
      ];

  }
}
