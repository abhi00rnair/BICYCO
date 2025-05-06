import 'package:bicyco/contribute.dart';
import 'package:bicyco/welcome.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  runApp(const Myapp());
}

final supabase = Supabase.instance.client;

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
