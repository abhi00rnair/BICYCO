import 'package:flutter/material.dart';
import 'package:seproject/screens/customnavigation.dart';
import 'package:seproject/screens/finepage.dart';
import 'package:seproject/screens/profile.dart';

class Contribute extends StatelessWidget {
  const Contribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('CONTRIBUTE', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Contribute Screen',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
