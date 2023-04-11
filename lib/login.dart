import 'package:flutter/material.dart';
import 'package:flutter_login/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Google Login beebee"),
        backgroundColor: Colors.red.shade700,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: size.height * 0.2,
            bottom: size.height * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Sign in with Google", style: TextStyle(fontSize: 30)),
            GestureDetector(
                onTap: () {
                  AuthService().signInWithGoogle();
                },
                child: const Image(
                    width: 200, image: AssetImage('assets/google.png'))),
          ],
        ),
      ),
    );
  }
}
