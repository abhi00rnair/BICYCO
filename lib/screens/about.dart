import 'package:flutter/material.dart';
import 'package:seproject/screens/customnavigation.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('About Bicyco'),
        backgroundColor: Colors.black,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Bicyco!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bicyco is a bicycle rental platform designed for students to easily book, return, and manage cycles within the campus. Our app ensures smooth and eco-friendly mobility through these core features:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Key Features:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '• View available cycles by department\n'
                '• Request and book a cycle for a desired duration\n'
                '• Track current bookings and return dates\n'
                '• Automatically calculated fines for late returns\n'
                '• Easy payment of fines through the app\n'
                '• Report issues related to rented cycles',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Our mission is to promote a sustainable and hassle-free commuting experience for the student community. Let\'s pedal towards a greener tomorrow!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.greenAccent,
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
