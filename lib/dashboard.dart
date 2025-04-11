import 'package:bicyco/customnavigation.dart';
import 'package:bicyco/finepage.dart';
import 'package:flutter/material.dart';
import 'package:bicyco/homescreen.dart';
import 'package:bicyco/welcome.dart';
import 'package:bicyco/profile.dart';

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
