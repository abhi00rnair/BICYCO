import 'package:flutter/material.dart';
import 'package:seproject/screens/customnavigation.dart';

class Rent extends StatefulWidget {
  const Rent({super.key});

  @override
  _RentState createState() => _RentState();
}

class _RentState extends State<Rent> {
  List<String> dept = ['CS', 'EC', 'EEE'];
  List<int> days = [1, 2, 3, 4];

  String? selectedDept;
  int? selectedDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'BOOK CYCLE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedDept,
                dropdownColor: Colors.grey[900],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
                hint: const Text("Select Department",
                    style: TextStyle(color: Colors.white)),
                items: dept.map((String department) {
                  return DropdownMenuItem<String>(
                    value: department,
                    child: Text(department,
                        style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDept = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<int>(
                value: selectedDays,
                dropdownColor: Colors.grey[900],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
                hint: const Text("Select No. of Days",
                    style: TextStyle(color: Colors.white)),
                items: days.map((int day) {
                  return DropdownMenuItem<int>(
                    value: day,
                    child: Text(day.toString(),
                        style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedDays = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 245, 184, 2),
                ),
                child: const Text(
                  'check availability',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 245, 184, 2),
                ),
                child: Text(
                  'BOOK NOWW',
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
