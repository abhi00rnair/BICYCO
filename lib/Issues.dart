import 'package:bicyco/customnavigation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  final TextEditingController issuecontroller = TextEditingController();
  List<String> cycleIds = [];
  String? selectedcycle;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCycleIds();
  }

  Future<void> fetchCycleIds() async {
    try {
      final response =
          await Supabase.instance.client.from('cycles').select('cycle_id');

      setState(() {
        cycleIds = List<String>.from(
            response.map((item) => item['cycle_id'].toString()));
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching cycle IDs: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error fetching cycle IDs")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Damage Reporting',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Cycle ID of the damaged Cycle',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
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
                      items: cycleIds.map((String id) {
                        return DropdownMenuItem<String>(
                          value: id,
                          child: Text(id,
                              style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedcycle = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: issuecontroller,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Enter details here',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 254, 184, 2),
                      ),
                      onPressed: () async {
                        if (selectedcycle == null ||
                            issuecontroller.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please select a cycle and enter the issue"),
                            ),
                          );
                          return;
                        }

                        try {
                          await Supabase.instance.client
                              .from('cycle_issues')
                              .insert({
                            'cycle_id': selectedcycle,
                            'description': issuecontroller.text.trim(),
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Issue reported successfully!")),
                          );

                          setState(() {
                            selectedcycle = null;
                            issuecontroller.clear();
                          });
                        } catch (e) {
                          print('Error reporting issue: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Failed to report issue")),
                          );
                        }
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.black),
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
