import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class Issues extends StatelessWidget {
  const Issues({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('issues'),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
