import 'package:bicyco/dashboard.dart';
import 'package:flutter/material.dart';

class signup extends StatelessWidget {
  const signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Sign up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '-------------------Login using nitc mail-------------------',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 320,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                }, //writethelogin
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 245, 184, 2),
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              textAlign: TextAlign.center,
              //softWrap: true,
              'By signing up, you agree to our Terms of Service and Privacy Policy',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
