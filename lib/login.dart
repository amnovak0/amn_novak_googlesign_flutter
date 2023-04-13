
import 'package:flutter/material.dart';
import 'package:flutter_login/auth_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

// import 'facebook_auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  
  //facebook trying out 
  
  //END OF 

 
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("HRnogomet"),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        margin: const EdgeInsets.all(50),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dobrodošli", 
              style: TextStyle(fontSize: 35),
              ),
              const Image(
                image: AssetImage('assets/hrnogomet.png'),
                width: 200,
                height: 200,
                ),
              Column(
                children: [        
                  SignInButton(Buttons.Google, onPressed:  () async {
                    await AuthService().signInWithGoogle();
                  }),
                  SignInButton(Buttons.FacebookNew, onPressed: () async {
                     await AuthService().facebookSignin();
                   }, )
                ],
                
              ),
              const Text("Sign in with email", style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),),
            ]),
      ),
    );
  }
}
