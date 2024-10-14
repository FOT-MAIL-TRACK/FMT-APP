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
  //Name Variables
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
    return prefs.getString('user_name');
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  Future<String?> getFaculty() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_faculty');
  }

  Future<String?> getUserRegNo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_Regno');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.teal, // Subtle color for app bar
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color(0xFFF0F0F0), // Light background color for the page
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/funnypic.jpeg'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 20),
              Text(
                "Hey, $uName!",
                style: const TextStyle(
                  color: Color(0xFF212121), // Darker color for contrast
                  fontWeight: FontWeight.bold,
                  fontSize: 28, // Slightly smaller font size for elegance
                ),
              ),
              const SizedBox(height: 20),
              _buildProfileInfo("Role", userRole),
              _buildProfileInfo("ID", userId),
              _buildProfileInfo("Username", userName),
              _buildProfileInfo("Faculty", uFaculty),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to display profile info
  Widget _buildProfileInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF757575), // Soft gray for labels
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? 'Not available',
            style: const TextStyle(
              color: Color(0xFF424242), // Dark text for values
              fontSize: 18,
            ),
          ),
          const Divider(color: Colors.grey), // Divider between profile fields
        ],
      ),
    );
  }
}
