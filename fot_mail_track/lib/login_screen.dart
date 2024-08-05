// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late TextEditingController usernameController;
//   late TextEditingController passwordController;

//   @override
//   void initState() {
//     super.initState();
//     usernameController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   // @override
//   // void dispose() {
//   //   usernameController.dispose();
//   //   passwordController.dispose();
//   //   super.dispose();
//   // }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('Login Screen'),
//             ),
//             body: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
//                     child: const FlutterLogo(
//                       size: 40,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                     child: TextField(
//                       controller: usernameController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(90.0),
//                         ),
//                         labelText: 'Email',
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                     child: TextField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(90.0),
//                         ),
//                         labelText: 'Password',
//                       ),
//                     ),
//                   ),
//                   Container(
//                       height: 80,
//                       padding: const EdgeInsets.all(20),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size.fromHeight(50),
//                         ),
//                         onPressed: () {},
//                         child: const Text('Log In'),
//                       )),
//                 ],
//               ),
//             )));
//   }
// }

//New Code
import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      await login(email, password);
    } catch (e) {
      print('Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
