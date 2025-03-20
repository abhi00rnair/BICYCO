import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class finepage extends StatelessWidget {
  const finepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('fine'),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
    );
  }
}
