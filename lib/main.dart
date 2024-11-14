import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist_app/data/hive_data_store.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/view/home/widgets/splash_view.dart';
import 'package:todolist_app/view/notifikasi.dart';

Future<void> main() async {
  /// Init Hive DB before runApp
  await Hive.initFlutter();

  /// Register Hive Adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  // Open a Box
  var box = await Hive.openBox<Task>(HivaDataStore.boxName);

  // This is step on necessary
  // Delete data from previous day
  box.values.forEach(
    (task) {
      if (task.createdAtTime?.day != DateTime.now().day) {
        task.delete();
      } else {
        // do nothing
      }
    },
  );

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel", 
        channelName: "basic_notification", 
        channelDescription: "tes notification channel",
        )
    ],
  channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: "basic_channel_group", 
      channelGroupName: "basic group"
      )
  ]);
  
    bool isAllowedToSendNotification =
    await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(BaseWidget(child: MyApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  final HivaDataStore dataStore = HivaDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MyNotif extends StatefulWidget {
  const MyNotif({super.key});

  @override
  State<MyNotif> createState() => _MyNotifState();
}

class _MyNotifState extends State<MyNotif> {
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: 
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayMethod,
        onDismissActionReceivedMethod: 
            NotificationController.onDismissActionReceivedMethod);
  super.initState(); 
} 
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

}
