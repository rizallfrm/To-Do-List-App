import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist_app/utils/app_colors.dart';
import 'package:todolist_app/utils/constants.dart';
import 'package:todolist_app/view/home/widgets/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryGradientColor,
                  begin: Alignment.bottomRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 200),
                Center(
                  child: Text(
                    'To Do App',
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Lottie.asset(
                lottieURLsplash, // Path ke file Lottie Anda
                width: 1000, // Sesuaikan ukuran sesuai kebutuhan
                height: 1200,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 550),
              child: Center(
                child: GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      isButtonPressed = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      isButtonPressed = false;
                    });
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => HomeView()),
                    );
                  },
                  onTapCancel: () {
                    setState(() {
                      isButtonPressed = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: isButtonPressed
                          ? LinearGradient(
                              colors: AppColors.primaryGradientColor,
                              begin: Alignment.bottomRight,
                              end: Alignment.centerLeft,
                            )
                          : null, // Use null to revert to original color
                      color: isButtonPressed ? null : Colors.white,
                    ),
                    child: Text(
                      "Let's Get Started",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isButtonPressed ? Colors.white : Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
