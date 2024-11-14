import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/extensions/space_exs.dart';
import 'package:todolist_app/main.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/utils/app_colors.dart';
import 'package:todolist_app/utils/app_str.dart';
import 'package:todolist_app/utils/constants.dart';
import 'package:todolist_app/view/home/widgets/task_view_appbar.dart';
import 'package:todolist_app/view/tasks/components/date_time_selection.dart';
import 'package:todolist_app/view/tasks/components/rep_textfield.dart';

class TaskView extends StatefulWidget {
  TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
  });

  final TextEditingController titleTaskController;
  final TextEditingController descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  //sebelum dieedit
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    title = widget.task?.title ?? '';
    subTitle = widget.task?.subTitle ?? '';
    time = widget.task?.createdAtTime ?? DateTime.now();
    date = widget.task?.createdAtDate ?? DateTime.now();
  }

//show selected Time as String Format
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime!)
          .toString();
    }
  }

  //show selected Date as DateFormat for init Time
  DateTime? showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate!;
    }
  }

  ///show Selected Time String Format
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate!).toString();
    }
  }

  bool isTasksAlreadyExists() {
    if (widget.titleTaskController.text.isEmpty &&
        widget.descriptionTaskController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///Main Function for creating or updating tasks
  dynamic isTaskAlreadyExistsUpdateOtherWiseCreate() {
    final title = widget.titleTaskController.text;
    final subTitle = widget.descriptionTaskController.text;

    if (title.isNotEmpty && subTitle.isNotEmpty) {
      try {
        if (widget.task != null) {
          // Update existing task
          widget.task!
            ..title = title
            ..subTitle = subTitle
            ..createdAtTime = time
            ..createdAtDate = date;

          widget.task!.save();
        } else {
          // Create a new task
          var newTask = Task.create(
            title: title,
            subTitle: subTitle,
            createdAtTime: time,
            createdAtDate: date,
            isCompleted: false,
          );

          // We are adding this new task to Hive DB
          BaseWidget.of(context).dataStore.addTask(task: newTask);
        }

        Navigator.pop(context); // Pop the page after saving/updating
      } catch (e) {
        updateTaskWarning(context);
      }
    } else {
      emptyWarning(context);
    }
  }

  //delete tasks
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: TaskViewAppbar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSideTexts(textTheme),
                _builMainATaskViewActivity(textTheme, context),
                _buildBottomSideButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSideButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTasksAlreadyExists()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTasksAlreadyExists()
              ? Container()
              :
              //delete current task Button
              MaterialButton(
                  onPressed: () {
                    deleteTask();
                    Navigator.pop(context);
                  },
                  minWidth: 150,
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 55,
                  child: Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                      ),
                      5.w,
                      Text(
                        AppStr.deleteTask,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

          //button update
          MaterialButton(
            onPressed: () {
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                    id: 1,
                    channelKey: "basic_channel",
                    title: "Tugas Telah Ditambahkan",
                    body:
                        "Jangan lupa untuk menyelesaikan tugasmu ya TEMAN \n Jangan hapus notif ini agar kamu selalu ingat tugasmu yaa!!!"),
              );
              isTaskAlreadyExistsUpdateOtherWiseCreate();
            },
            minWidth: 150,
            elevation: 5,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: Text(
              isTasksAlreadyExists()
                  ? AppStr.addTaskString
                  : AppStr.updateCurrentTask,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builMainATaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              AppStr.tittleOfTittleTextField,
              style: textTheme.titleSmall,
            ),
          ),
          //task title
          RepTextField(
            controller: widget.titleTaskController,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),
          10.h,
          //task title
          RepTextField(
            controller: widget.descriptionTaskController,
            isForDescription: true,
            onFieldSubmitted: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
            onChanged: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
          ),
          //time selection
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    initDateTime: showDateAsDateTime(time),
                    onChange: (dateTime, selectedIndex) {},
                    dateFormat: 'HH:mm',
                    onConfirm: (dateTime, selectedIndex) {
                      setState(() {
                        time = dateTime;
                      });
                    },
                  ),
                ),
              );
            },
            title: "Time",
            time: showTime(time),
          ),
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                initialDateTime: showDateAsDateTime(date),
                onConfirm: (dateTime, _) {
                  setState(() {
                    date = dateTime;
                  });
                },
              );
            },
            title: AppStr.dateString,
            isTime: true,
            time: showDate(date),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: isTasksAlreadyExists()
                  ? AppStr.addNewTask
                  : AppStr.updateCurrentTask,
              style: textTheme.bodyLarge,
              children: [
                TextSpan(
                    text: AppStr.taskString,
                    style: TextStyle(fontWeight: FontWeight.w400))
              ],
            ),
          ),
          SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
