// import 'package:flutter/material.dart';
// import 'package:fot_mail_track/home_screen.dart';
// import 'package:fot_mail_track/services/auth_service.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthService _authService =
//       AuthService(); // Create an instance of AuthService

//   void _handleLogin() async {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//     try {
//       await _authService.login(email, password); // Use the AuthService instance

//       // If login is successful, navigate to HomePage
//       Navigator.pushReplacement(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } catch (e) {
//       // ignore: avoid_print
//       print('Login error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Column(
//                   children: [
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Image.asset(
//                       'assets/fmt.png',
//                       width: 200,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                     const SizedBox(
//                       height: 90,
//                     )
//                   ],
//                 ),
//                 const Text(
//                     "Please Enter Your Account Details to Sign in to the System"),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 TextField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: 200,
//                   child: FilledButton(
//                     onPressed: _handleLogin,
//                     child: const Text('Login'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//new code

import 'package:flutter/material.dart';
import 'package:fot_mail_track/home_screen.dart';
import 'package:fot_mail_track/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = ''; // Error message variable

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      await _authService.login(email, password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid credentials. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'assets/fmt.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
                const Text(
                    "Please Enter Your Account Details to Sign in to the System"),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 120,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      // Black button background
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Square shape
                      ),
                    ),
                    onPressed: _handleLogin,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
