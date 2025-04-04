import 'package:bicyco/About.dart';
import 'package:bicyco/Exchange.dart';
import 'package:bicyco/Issues.dart';
import 'package:bicyco/Rent.dart';
import 'package:bicyco/contribute.dart';
import 'package:bicyco/leaderboard.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: const Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi Arjun',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(width: 100),
            Icon(
              Icons.pedal_bike_outlined,
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {}, //functionaltntobeimplemented
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
                buildrow(context, 'Rent', Icons.pedal_bike, Rent(), 'Issues',
                    Icons.warning, Issues()),
                const SizedBox(height: 20),
                buildrow(context, 'About', Icons.info, about(), 'Contribute',
                    Icons.handshake_outlined, contribute()),
                const SizedBox(height: 20),
                buildrow(context, 'Exchange', Icons.sell_outlined, exchange(),
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
