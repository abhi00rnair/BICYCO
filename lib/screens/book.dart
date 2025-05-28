import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seproject/screens/url.dart';

import 'package:seproject/services/api.dart';

class book extends StatefulWidget {
  final String cycleid;
  final bool status;
  final String roll;
  book(
      {super.key,
      required this.cycleid,
      required this.status,
      required this.roll});

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  String selectedDays = '1';
  final List<String> daysList = ['1', '2', '3', '4', '5'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'BOOK CYCLE',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 3, 3),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'lib/images/11.png',
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  Text("Cycle ID: ${widget.cycleid}",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                      "Status: ${widget.status ? 'Available' : 'Not Available'}",
                      style: TextStyle(
                          fontSize: 16,
                          color: widget.status ? Colors.green : Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedDays,
              items: daysList.map((String day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text(
                    '$day day(s)',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDays = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Number of Days',
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.black,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                try {
                  ApiService api = ApiService(baseUrl: baseUrl);
                  api.changecyclestate(widget.cycleid);
                  api.bookfine(widget.cycleid, widget.roll);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cycle booked successfully!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking failed: ${e.toString()}')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text(
                'BOOK NOW',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
