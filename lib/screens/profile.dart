import 'package:flutter/material.dart';
import 'package:seproject/screens/customnavigation.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String rollno = '';
  String email = '';
  bool isLoading = true;

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 450,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 254, 184, 2),
                          Colors.white
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('lib/images/logo.jpg'),
                        ),
                        const SizedBox(height: 20),
                        Text(name, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 20),
                        Text(rollno, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 20),
                        Text(email, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("EDIT PROFILE"),
                        ),
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
