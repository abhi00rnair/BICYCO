import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('rent a bycyle'),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
