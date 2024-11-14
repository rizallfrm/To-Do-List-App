import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/main.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/view/record_detail_page.dart';

class DataRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.ListenToTask(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();
        tasks.sort((a, b) => a.createdAtDate!.compareTo(b.createdAtDate!));

        return Scaffold(
          appBar: AppBar(
            title: Text('Data Record')
          ),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return ListTile(
                title: Text(task.title ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.subTitle ?? ''),
                    SizedBox(height: 4),
                    Text(
                      'Created At: ${DateFormat.yMMMEd().add_jm().format(task.createdAtDate!)}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecordDetailPage(task: task),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
