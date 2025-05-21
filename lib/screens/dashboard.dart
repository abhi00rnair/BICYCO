import 'package:flutter/material.dart';
import 'package:seproject/screens/customnavigation.dart';
import 'package:seproject/screens/finepage.dart';
import 'package:seproject/screens/homescreen.dart';
import 'package:seproject/screens/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int myindex = 0;

  final List<Widget> wd = [
    Homescreen(),
    finepage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: wd[myindex],
      bottomNavigationBar: CustomBottomNavBar(currentIndex: myindex),
    );
  }
}
