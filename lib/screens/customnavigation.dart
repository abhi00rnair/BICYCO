import 'package:flutter/material.dart';
import 'package:seproject/screens/dashboard.dart';
import 'package:seproject/screens/finepage.dart';
import 'package:seproject/screens/profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = Dashboard();
        break;
      case 1:
        nextScreen = finepage();
        break;
      case 2:
        nextScreen = Profile();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => _onItemTapped(context, index),
      currentIndex: currentIndex,
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
