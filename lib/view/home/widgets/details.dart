import 'package:flutter/material.dart';
import 'package:todolist_app/utils/app_colors.dart';

class Developer {
  final String name;
  final String subtitle; // Tambahkan subtitle di sini
  final String imagePath;

  Developer(
      {required this.name, required this.subtitle, required this.imagePath});
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final developers = [
      Developer(
          name: "Alaika Tegar",
          subtitle: "22SA11A037",
          imagePath: "assets/tegar.jpg"),
      Developer(
          name: "Manggala Yuda",
          subtitle: "22SA11A046",
          imagePath: "assets/manggala.jpg"),
      Developer(
          name: "Farhan Rafi",
          subtitle: "22SA11A048",
          imagePath: "assets/farhan.jpg"),
      Developer(
          name: "Rizal Firmansyah",
          subtitle: "22SA11A075",
          imagePath: "assets/rizaal.jpg"),
      Developer(
          name: "Annisa Qotrunnada",
          subtitle: "22SA11A087",
          imagePath: "assets/anisa.jpg"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Developer Team",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            ...developers
                .map((developer) => DeveloperCard(developer: developer))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final Developer developer;

  const DeveloperCard({Key? key, required this.developer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0), // Add padding for more space
        leading: CircleAvatar(
          radius: 40, // Increase the radius for larger image
          backgroundImage:
              AssetImage(developer.imagePath), // Use the developer's image
          backgroundColor: Colors.grey[200],
        ),
        title: Text(
          developer.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          developer.subtitle, // Tampilkan subtitle di sini
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
