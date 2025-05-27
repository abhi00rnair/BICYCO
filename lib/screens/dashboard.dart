import 'package:flutter/material.dart';
import 'package:seproject/screens/customnavigation.dart';
import 'package:seproject/screens/finepage.dart';
import 'package:seproject/screens/homescreen.dart';
import 'package:seproject/screens/profile.dart';
import 'package:seproject/models/profilemodel.dart';
import 'package:seproject/services/api.dart';
import 'package:seproject/screens/url.dart';

class Dashboard extends StatefulWidget {
  final String idToken;
  const Dashboard({super.key, required this.idToken});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int myindex = 0;
  ProfileModel? studentProfile;
  bool isLoading = true;

  final List<Widget> fallbackScreens = [
    Center(child: CircularProgressIndicator()),
    Center(child: CircularProgressIndicator()),
    Center(child: CircularProgressIndicator()),
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final apiService = ApiService(baseUrl: baseUrl);
    final profile = await apiService.fetchStudentDetails(widget.idToken);
    if (mounted) {
      setState(() {
        studentProfile = profile;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = isLoading
        ? fallbackScreens
        : [
            Homescreen(profile: studentProfile!, idToken: widget.idToken),
            finepage(profile: studentProfile!),
            Profile(profile: studentProfile!),
          ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: myindex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: myindex,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
      ),
    );
  }
}
