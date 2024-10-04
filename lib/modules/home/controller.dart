import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/data/models/task.dart';
import 'package:getx_todo_list/data/service/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteTask(Task task){
    tasks.remove(task);
  }

  void changeTask(Task? select){
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for(int i = 0; i < select.length; i++){
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      try {
        tasks.add(task);
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos,title))return false;
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }
  bool containTodo(List todos, String title) {
    return todos.any((element) => element["title"] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};

    if(doingTodos.any((e)=> mapEquals<String, dynamic>(todo,e))){
      return false;
    }
    var doneTodo = {'title': title, 'done': true};
    if(doneTodos.any((e)=>mapEquals(doneTodo,e ))){
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos(){
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos
    ]);

    var newTask = task.value!.copyWith(todos: newTodos);
    bool containsTask = tasks.contains(task.value);
    if(containsTask){
      int oldIdx = tasks.indexOf(task.value);
      tasks[oldIdx] = newTask;
      tasks.refresh();
    }
  }

  void doneTodo(String title) {
    var doingTodo = {title: title, 'done': false};
    int index = doingTodos.indexWhere((e)=> mapEquals<String,dynamic>(doingTodo, e));
    doingTodos.removeAt(index);
    var doneTodo = {title: title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }
}

