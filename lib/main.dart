import 'package:bicyco/Exchange.dart';
import 'package:bicyco/Profile.dart';
import 'package:bicyco/dashboard.dart';
import 'package:bicyco/finepage.dart';
import 'package:bicyco/homescreen.dart';
import 'package:bicyco/signup.dart';
import 'package:bicyco/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profile(),
    );
  }
}
