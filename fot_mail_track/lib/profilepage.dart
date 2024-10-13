import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  //Create AuthServices Instant
  final AuthService _authService = AuthService();
  //Name Veriables
  String? userId;
  String? userRole;
  String? userName;
  String? uName;
  String? userRegNo;
  String? uFaculty;

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Load the userId when the screen is initialized
  }

  Future<void> _loadUserId() async {
    userRegNo = await getUserRegNo();
    userName = await getUserUName();
    userRole = await getUserRole();
    userId = await getUserId();
    uName = await getName();
    uFaculty = await getFaculty();
    print("User Role is : $userRole");
    setState(() {}); // Update the UI after loading userId
  }

  Future<String?> getUserUName() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString('user_name');

    return userName;
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userRole = prefs.getString('user_role');

    return userRole;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('user_id');

    return userId;
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    final String? uName = prefs.getString('name');

    return uName;
  }

  Future<String?> getFaculty() async {
    final prefs = await SharedPreferences.getInstance();
    final String? uFaculty = prefs.getString('user_faculty');

    return uFaculty;
  }

  Future<String?> getUserRegNo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userRegNo = prefs.getString('user_Regno');
    return userRegNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        color: const Color.fromARGB(31, 156, 143, 143),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "Hey $uName",
                style: const TextStyle(
                    color: Color.fromARGB(255, 33, 30, 30),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/funnypic.jpeg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Role : $userRole"),
              const SizedBox(
                height: 40,
              ),
              Text("Id : $userId"),
              const SizedBox(
                height: 40,
              ),
              Text("User Name : $userName"),
              const SizedBox(
                height: 40,
              ),
              Text("Faculty : $uFaculty"),
            ],
          ),
        ),
      ),
    );
  }
}
