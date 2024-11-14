import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/utils/app_colors.dart';
import 'package:todolist_app/view/home/widgets/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskControllerForTitle.text = widget.task.title!;
    taskControllerForSubtitle.text = widget.task.subTitle!;
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Initialize the controllers with task's title and subtitle
        taskControllerForTitle.text = widget.task.title!;
        taskControllerForSubtitle.text = widget.task.subTitle!;

        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              titleTaskController: taskControllerForTitle,
              descriptionTaskController: taskControllerForSubtitle,
              task: widget.task,
            ),
          ),
        );
      },
      // Main card
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.task.isCompleted!
              ? const Color.fromARGB(154, 119, 144, 229)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: Offset(0, 4),
              blurRadius: 10,
            )
          ],
        ),
        child: ListTile(
          // Check icon
          leading: GestureDetector(
            onTap: () {
              setState(() {
                widget.task.isCompleted = !widget.task.isCompleted!;
                widget.task.save();
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: widget.task.isCompleted!
                    ? AppColors.primaryColor
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          // Title of Task
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              widget.task.title!,
              style: TextStyle(
                color: widget.task.isCompleted!
                    ? AppColors.primaryColor
                    : Colors.black,
                fontWeight: FontWeight.w500,
                decoration:
                    widget.task.isCompleted! ? TextDecoration.none : null,
              ),
            ),
          ),

          // Description of task
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.subTitle!,
                style: TextStyle(
                  color: widget.task.isCompleted!
                      ? AppColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration:
                      widget.task.isCompleted! ? TextDecoration.none : null,
                ),
              ),

              // Date & time
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a')
                            .format(widget.task.createdAtTime!),
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.task.isCompleted!
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate!),
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.task.isCompleted!
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
