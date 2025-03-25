import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class contribute extends StatelessWidget {
  const contribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Title(
          color: Colors.white,
          child: Text(
            'CONTRIBUTE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
