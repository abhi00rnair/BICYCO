import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class exchange extends StatelessWidget {
  const exchange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Exchange Screen',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
