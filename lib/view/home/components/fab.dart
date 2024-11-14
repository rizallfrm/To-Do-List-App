import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/utils/app_colors.dart';
//import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/view/home/widgets/task_view.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        TextEditingController titleController = TextEditingController();
        TextEditingController descriptionController = TextEditingController();
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => TaskView(
                titleTaskController: titleController,
                descriptionTaskController: descriptionController,
                task: null,
              ),
            ));
      },
      child: Material(
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(Icons.add, color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
