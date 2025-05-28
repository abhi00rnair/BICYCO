import 'package:flutter/material.dart';
import 'package:seproject/models/profilemodel.dart';
import 'package:seproject/screens/about.dart';
import 'package:seproject/screens/contribute.dart';
import 'package:seproject/screens/exchange.dart';
import 'package:seproject/screens/issues.dart';
import 'package:seproject/screens/leaderboard.dart';
import 'package:seproject/screens/profile.dart';
import 'package:seproject/screens/rent.dart';

class Homescreen extends StatelessWidget {
  final ProfileModel profile;
  final String idToken;
  const Homescreen({super.key, required this.profile, required this.idToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(width: 150),
            Icon(Icons.pedal_bike_outlined, color: Colors.white, size: 35),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              child: Center(
                child: Image.asset(
                  'lib/images/map.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildrow(
                    context,
                    'Rent',
                    Icons.pedal_bike,
                    Rent(
                      idToken: idToken,
                      roll: profile.rollNo,
                    ),
                    'Issues',
                    Icons.warning,
                    Issues()),
                const SizedBox(height: 20),
                buildrow(context, 'About', Icons.info, About(), 'Contribute',
                    Icons.handshake_outlined, Contribute()),
                const SizedBox(height: 20),
                buildrow(context, 'Exchange', Icons.sell_outlined, Exchange(),
                    'Leaderboard', Icons.leaderboard, Leaderboard()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildrow(BuildContext context, String text1, IconData icon1,
    Widget page1, String text2, IconData icon2, Widget page2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      button(context, text1, icon1, page1),
      button(context, text2, icon2, page2),
    ],
  );
}

Widget button(BuildContext context, String text, IconData icon, Widget page) {
  return SizedBox(
    width: 150,
    height: 80,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 245, 184, 2),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
