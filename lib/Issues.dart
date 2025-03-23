import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  final TextEditingController issuecontroller = TextEditingController();
  List<String> cycleid = ['001', '002', '003', '004'];
  String? selectedcycle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Damage Reporting',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Cycle ID of the damaged Cycle',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedcycle,
                dropdownColor: Colors.grey[900],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
                hint: const Text(
                  'Select Cycle',
                  style: TextStyle(color: Colors.white),
                ),
                items: cycleid.map((String department) {
                  return DropdownMenuItem<String>(
                    value: department,
                    child: Text(department,
                        style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      selectedcycle = newValue!;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Describe the Issue',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: issuecontroller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        hintText: 'enetr details here',
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 254, 184, 2)),
                    onPressed: () {},
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
