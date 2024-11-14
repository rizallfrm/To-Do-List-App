//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart' as core_patch;

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist_app/models/task.dart';
//import 'package:todolist_app/view/home/widgets/task_view.dart';

/// All The [CRUD] operation method For Hive DB
class HivaDataStore {
  // Box name - String
  static const boxName = 'taskBox';
  // Our current Box with all the saved data inside - Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);
  // Add new Task To Box
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  /// Show Task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Update Task
  Future<void> update({required Task task}) async {
    await task.save();
  }

  /// Delete Task
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  /// Listen to Box Changes
  /// using this method we will listen to box changes and update the
  /// UI accordingly
  ValueListenable<Box<Task>> ListenToTask() => box.listenable();
}
