import 'package:carrental/services/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:carrental/pages/loginpage.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        margin: EdgeInsets.all(55),
        child: Column(
          children: [
            Image.asset("images/Logo.png"),
            SizedBox(height: 25.0, width: 25.0),
            Text(
              "SwiftWheels",
              textAlign: TextAlign.center,
              style: AppWidget.heading(),
            ),
            Text(
              "Fast. Fair. Effortless.",
              textAlign: TextAlign.center,
              style: AppWidget.subhead(),
            ),
            SizedBox(height: 50.0),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const loginpage()),
                  );
                },
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 10, 63, 177),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
