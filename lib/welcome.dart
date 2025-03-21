import 'package:bicyco/signup.dart';
import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center all items
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'lib/images/welcomeimage.png',
                height: 200,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 135),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const signup()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 245, 184, 2),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 300,
                  child: Text(
                    'By signing up, you agree to our Terms of Service and Privacy Policy',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
