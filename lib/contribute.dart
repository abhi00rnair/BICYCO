import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class contribute extends StatelessWidget {
  const contribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('contribute'),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
