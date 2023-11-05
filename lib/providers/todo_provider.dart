import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_notes/model/todo_list.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoList> _todoList = [];

  List<TodoList> get todoList => _todoList;

  void addTodo(TodoList todo) {
    _todoList.add(todo);
    saveTodos();
    notifyListeners();
  }

  void deleteTodo(TodoList todo) {
    _todoList.remove(todo);
    saveTodos();
    notifyListeners();
  }

  void editTodo(TodoList oldTodo, TodoList newTodo) {
    int index = _todoList.indexOf(oldTodo);
    if (index != -1) {
      _todoList[index] = newTodo;
      saveTodos();
      notifyListeners();
    }
  }

  Future<void> saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoStringList =
        _todoList.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList('todoList', todoStringList);
  }

  Future<void> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoStringList = prefs.getStringList('todoList');
    if (todoStringList != null) {
      _todoList =
          todoStringList.map((e) => TodoList.fromjson(jsonDecode(e))).toList();
      notifyListeners();
    }
  }
}
