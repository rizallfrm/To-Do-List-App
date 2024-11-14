import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist_app/models/task.dart';

class DataStore {
  final Box<Task> taskBox;
  final Box<Task> recordBox;

  DataStore({required this.taskBox, required this.recordBox});

  ValueListenable<Box<Task>> listenToTasks() {
    return taskBox.listenable();
  }

  ValueListenable<Box<Task>> listenToRecords() {
    return recordBox.listenable();
  }

  void addTask({required Task task}) {
    taskBox.add(task);
  }

  void deleteTask(Task task) {
    taskBox.delete(task.key);
    // Add to records box instead of deleting completely
    recordBox.add(task);
  }

  void deleteAllRecords() {
    recordBox.clear();
  }
}
