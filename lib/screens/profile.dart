import 'package:flutter/material.dart';
import 'package:seproject/models/profilemodel.dart';
import 'package:seproject/screens/customnavigation.dart';

class Profile extends StatefulWidget {
  final ProfileModel profile;

  const Profile({super.key, required this.profile});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String rollno = '';
  String email = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    name = widget.profile.name;
    rollno = widget.profile.rollNo;
    email = widget.profile.emailId;

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'PROFILE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  Center(
                    child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('lib/images/dp.jpg'),
                          ),
                          const SizedBox(height: 20),
                          Text(name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
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
                  ),
                ],
              ),
            ),
    );
  }
}
