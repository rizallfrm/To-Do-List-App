import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/utils/constants.dart';
import 'package:todolist_app/view/home/widgets/home_view.dart';

class RecordDetailPage extends StatelessWidget {
  final Task task;

  const RecordDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Detail'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => HomeView()));
                },
                child: Icon(
                  Icons.home,
                  size: 35,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? '',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Lottie.asset(lottieURLact),
            Text(
              task.subTitle ?? '',
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(height: 16),
            Text(
              'Dikerjakan : ${DateFormat.yMMMEd().add_jm().format(task.createdAtDate!)}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
