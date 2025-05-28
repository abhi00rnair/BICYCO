import 'package:flutter/material.dart';
import 'package:seproject/models/finemodel.dart';
import 'package:seproject/models/profilemodel.dart';
import 'package:seproject/screens/payment.dart';
import 'package:seproject/screens/profile.dart';
import 'package:seproject/screens/url.dart';
import 'package:seproject/services/api.dart';

class finepage extends StatefulWidget {
  final ProfileModel profile;
  const finepage({super.key, required this.profile});

  @override
  State<finepage> createState() => _finepageState();
}

class _finepageState extends State<finepage> {
  late Future<List<Fine>> fineFuture;

  @override
  void initState() {
    super.initState();
    fineFuture = fetchFinesForUser(widget.profile.rollNo);
  }

  Future<List<Fine>> fetchFinesForUser(String rollNo) async {
    final apiService = ApiService(baseUrl: baseUrl);
    final fine = await apiService.fetchfine(widget.profile.rollNo);
    if (fine == null) {
      return [];
    } else {
      return [fine];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'FINE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Fine>>(
        future: fineFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No fines available',
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            final fines = snapshot.data!;
            return ListView.builder(
              itemCount: fines.length,
              itemBuilder: (context, index) {
                final fine = fines[index];
                return finebox(
                  context,
                  fine.cycleId,
                  fine.date.toString().split(" ")[0],
                  fine.fine.toDouble(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Widget finebox(BuildContext context, String id, String date, double amount) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 5,
          spreadRadius: 2,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cycle ID: $id",
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Date: $date",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              "Amount: ₹$amount",
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => payment(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 245, 184, 2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Pay Now",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
