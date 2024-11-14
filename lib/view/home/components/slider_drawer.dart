import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/extensions/space_exs.dart';
import 'package:todolist_app/utils/app_colors.dart';
import 'package:todolist_app/view/home/widgets/data_record.dart';
import 'package:todolist_app/view/home/widgets/details.dart';
import 'package:todolist_app/view/home/widgets/home_view.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  /// Icons
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.list_dash,
    CupertinoIcons.info_circle_fill,
  ];

  /// Texts
  final List<String> texts = [
    "Home",
    "History",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    //var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: AppColors.primaryGradientColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              "assets/profile.png",
            ),
          ),
          8.h,
          Text("Kelompok Pubspec",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          Text("Pemrograman Mobile IF22B",
              style: TextStyle(fontSize: 15, color: Colors.white)),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    //home slider
                    if (index == 0) {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => HomeView()));
                    }
                    //history slider
                    if (index == 1) {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DataRecord()));
                    }
                    //details slider
                    if (index == 2) {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Details()));
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        texts[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
