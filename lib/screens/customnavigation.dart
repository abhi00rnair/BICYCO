import 'package:flutter/material.dart';
import 'package:seproject/screens/dashboard.dart';
import 'package:seproject/screens/finepage.dart';
import 'package:seproject/screens/profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap; // add this

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap, // require onTap
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap, // pass onTap here
      selectedItemColor: Color.fromARGB(255, 245, 184, 2),
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.pedal_bike), label: 'Cycle'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
