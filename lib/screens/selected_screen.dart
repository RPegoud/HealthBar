import 'package:auth/screens/dashboard_screen.dart';
import 'package:auth/screens/meals_screen.dart';
import 'package:auth/screens/training_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashboard_screen.dart';

class SelectedScreen extends StatefulWidget {
  const SelectedScreen({Key? key}) : super(key: key);

  @override
  SelectedScreenState createState() => SelectedScreenState();
}

class SelectedScreenState extends State<SelectedScreen> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    DashScreen(),
    TrainingScreen(),
    MealScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.data_saver_off,
              color: Colors.black,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center_rounded,
              color: Colors.black,
            ),
            label: 'Training Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank,
              color: Colors.black,
            ),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            label: 'Sign Out',
          )
        ],
        currentIndex: pageIndex,
        selectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            if (value != 3) {
              pageIndex = value;
            }
            if (value == 3) {
              FirebaseAuth.instance.signOut();
            }
          });
        },
      ),
    );
  }
}
