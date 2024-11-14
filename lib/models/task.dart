import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    this.subTitle,
    this.createdAtTime,
    this.createdAtDate,
    this.isCompleted,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? subTitle;

  @HiveField(3)
  DateTime? createdAtTime;

  @HiveField(4)
  DateTime? createdAtDate;

  @HiveField(5)
  bool? isCompleted;

  // Create new task
  factory Task.create({
    required String title,
    String? subTitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate, required bool isCompleted,
  }) =>
      Task(
        id: Uuid().v1(),
        title: title,
        subTitle: subTitle ?? "",
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate: createdAtDate ?? DateTime.now(),
        isCompleted: false,
      );
}
