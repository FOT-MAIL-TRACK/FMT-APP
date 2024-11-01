import 'package:flutter/material.dart';
import 'package:fot_mail_track/profilepage.dart';
import 'package:fot_mail_track/qr_scanner.dart';
import 'package:fot_mail_track/status_screen.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _result;
  int currentPageIndex = 0;

  Toast toast = Toast();

  final List<Widget> _screens = [
    Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(25.25),
          child: const Text(
            'FOT-MAIL-TRACK App solution',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(25.25),
          child: const Text(
            'The Faculty of Technology Mail Tracking System aims to streamline and enhance the process of managing and tracking physical mail within the faculty of technology, university of Sri Jayawardenepura. The mobile application will allow users to scan QR codes to verify the passage of mail through designated authorities.',
          ),
        )
      ],
    )),
    const QRscanner(),
    const StatusScreen(),
  ];

  void setResult(String result) {
    setState(() => _result = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FOT - MAIL - TRACK',
          style: TextStyle(
            fontFamily: 'Roboto-Bold',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 5),
          ),
        ),
        backgroundColor: const Color.fromARGB(31, 70, 41, 41),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profilepage()),
              );
            },
            icon: Image.asset(
              'assets/profile.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: _screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 61, 133, 209),
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Image.asset(
              'assets/home.png',
              width: 40,
              height: 40,
            ),
            icon: Image.asset(
              'assets/home.png',
              width: 20,
              height: 20,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              'assets/qrscan.png',
              width: 40,
              height: 40,
            ),
            icon: Badge(
              child: Image.asset(
                'assets/qrscan.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'QR Scan',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              'assets/status.png',
              width: 40,
              height: 40,
            ),
            icon: Badge(
              label: const Text('2'),
              child: Image.asset(
                'assets/status.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}
