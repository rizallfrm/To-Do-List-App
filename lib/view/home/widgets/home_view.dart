import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist_app/extensions/space_exs.dart';
import 'package:todolist_app/main.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/utils/app_colors.dart';
import 'package:todolist_app/utils/app_str.dart';
import 'package:todolist_app/utils/constants.dart';
import 'package:todolist_app/view/home/components/fab.dart';
import 'package:todolist_app/view/home/components/home_app_bar.dart';
import 'package:todolist_app/view/home/components/slider_drawer.dart';
import 'package:todolist_app/view/home/widgets/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  //List test = [1];

  //check value of circle Indicator
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  //check done tasks
  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted!) {
        i++;
      }
    }
    return i;
  }
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.ListenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();
          // for sorting List
          tasks.sort((a, b) => a.createdAtDate!.compareTo(b.createdAtDate!));
          return Scaffold(
            backgroundColor: Colors.white,

            ///FAB
            floatingActionButton: const Fab(),

            ///BODY

            body: SliderDrawer(
              key: drawerKey,
              isDraggable: false,
              animationDuration: 1000,

              ///DRAWER
              slider: CustomDrawer(),

              appBar: HomeAppBar(
                drawerKey: drawerKey,
              ),

              /// Main Body
              child: _buildHomeBody(textTheme, base, tasks),
            ),
          );
        });
  }

//HOME BODY
  Widget _buildHomeBody(
      TextTheme textTheme, BaseWidget base, List<Task> tasks) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Custom app bar
            Container(
              margin: EdgeInsets.only(top: 60),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Progress indicator
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor),
                    ),
                  ),
                  25.w,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStr.mainTitle,
                        style: textTheme.displayLarge,
                      ),
                      3.h,
                      Text(
                        "${checkDoneTask(tasks)} of ${tasks.length} task",
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Divider
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 2,
                indent: 100,
              ),
            ),

            // Task
            SizedBox(
              width: double.infinity,
              height: 500,
              child: tasks.isNotEmpty

                  ///task list is not empty
                  ? ListView.builder(
                      itemCount: tasks.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        /// Get the single Task for showing in list
                        var task = tasks[index];
                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            //we will remove current task from DB
                            base.dataStore.deleteTask(task: task);
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              8.w,
                              Text(
                                AppStr.deleteTask,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          key: Key(task.id),
                          child: TaskWidget(task: task),
                        );
                      })

                  ///task list empty
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: tasks.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                        FadeInUp(
                          from: 30,
                          child: Text(AppStr.doneAllTask),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
