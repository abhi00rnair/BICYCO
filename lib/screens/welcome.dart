import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:seproject/screens/dashboard.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
      serverClientId: dotenv.env['GOOGLE_CLIENT_ID'],
    );
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final email = account.email;

        if (email.endsWith('@nitc.ac.in')) {
          final GoogleSignInAuthentication auth = await account.authentication;
          final idToken = auth.idToken;
          print("Id token received**: $idToken");

          if (idToken != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );

            _startAutoSignOutTimer(context, googleSignIn);
          } else {
            print('idToken is null');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to get idToken from Google'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          await googleSignIn.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Only @nitc.ac.in emails are allowed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  void _startAutoSignOutTimer(BuildContext context, GoogleSignIn googleSignIn) {
    Timer(Duration(seconds: 30), () async {
      await googleSignIn.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Welcome()),
      );
      print("User signed out due to inactivity.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      _handleGoogleSignIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 245, 184, 2),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
