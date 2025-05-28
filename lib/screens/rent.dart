import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seproject/screens/url.dart';
import 'package:seproject/models/cyclemodel.dart';
import 'package:seproject/screens/book.dart';
import 'package:seproject/services/api.dart';

class Rent extends StatefulWidget {
  final String idToken;
  final String roll;
  const Rent({super.key, required this.idToken, required this.roll});

  @override
  RentState createState() => RentState();
}

class RentState extends State<Rent> {
  late Future<List<Cycle>> _cycleFuture;
  final ApiService apiService = ApiService(baseUrl: baseUrl);

  @override
  void initState() {
    super.initState();
    _cycleFuture = apiService.fetchCycleDetails(widget.idToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'BOOK CYCLE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Cycle>>(
        future: _cycleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No cycles available',
                    style: TextStyle(color: Colors.white)));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CycleBox(
                  c1: snapshot.data![index],
                  roll: widget.roll,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CycleBox extends StatefulWidget {
  final String roll;
  final Cycle c1;
  const CycleBox({super.key, required this.c1, required this.roll});

  @override
  State<CycleBox> createState() => _CycleBoxState();
}

class _CycleBoxState extends State<CycleBox> {
  String dropdownValue = '1 Day';

  final List<String> daysOptions = ['1 Day', '2 Days', '3 Days'];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[800],
              ),
              child: Image.asset('lib/images/11.png'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cycle ID: ${widget.c1.cycleId}",
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(
                    "Status: ${widget.c1.status ? 'Available' : 'Not Available'}",
                    style: const TextStyle().copyWith(
                        color: widget.c1.status
                            ? Color.fromARGB(179, 63, 219, 24)
                            : Colors.red),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*DropdownButton<String>(
                        value: dropdownValue,
                        dropdownColor: Colors.black,
                        iconEnabledColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        items: daysOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),*/
                      ElevatedButton(
                        onPressed: () async {
                          if (widget.c1.status == true) {
                            final apiService = ApiService(baseUrl: baseUrl);
                            final fine =
                                await apiService.fetchfine(widget.roll);

                            if (fine == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => book(
                                      cycleid: widget.c1.cycleId,
                                      status: widget.c1.status,
                                      roll: widget.roll),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Booking Denied"),
                                  content: Text(
                                      "You have a pending fine. Please clear it before booking."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 254, 184, 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Check out"),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
