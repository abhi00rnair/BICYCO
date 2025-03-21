import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
    );
  }
}
