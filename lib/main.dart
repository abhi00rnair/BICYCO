import 'package:bicyco/contribute.dart';
import 'package:bicyco/welcome.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://pmnjpuwcxpgxkatbuqgd.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBtbmpwdXdjeHBneGthdGJ1cWdkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQzMTY0ODMsImV4cCI6MjA1OTg5MjQ4M30.RDwsMdnanELr3ChRotMcFiNZn8FUMjjNCljRZFMwe9U",
    realtimeClientOptions: RealtimeClientOptions(
      timeout: Duration(seconds: 10),
    ),
  );
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
