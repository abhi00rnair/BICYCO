import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'PROFILE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
            ),
            Container(
              width: 300,
              height: 450,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 254, 184, 2), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('lib/images/logo.jpg'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('ARJUN SARATH'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('B220112CS'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("arjunsarath@gmail.com"),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("EDIT PROFILE"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
    );
  }
}
