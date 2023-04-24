
import 'package:flutter/gestures.dart';
import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/sign_up.dart';
import 'package:flutter_login/auth_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api/post.dart';

// import 'facebook_auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // IMPLEMENTING POST METHOD 
  Future<User>? _futureAlbum;

  //PASSWORD HIDING 
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
        _isHidden = !_isHidden;
    });
  }

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
      body: SizedBox(
        width: size.width,
        height: size.height,
        // margin: const EdgeInsets.all(70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Dobrodošli",
              style: TextStyle(fontSize: 35),
            ),
            const Image(
              image: AssetImage('assets/hrnogomet.png'),
              width: 200,
              height: 150,
            ),
            SizedBox(
                child: Column(
              children: [
                Text(
                  "Prijavi se u korisnički račun",
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.shade500.withOpacity(0.2),
                        )
                      ]),
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: ("Korisničko ime ili email: "),
                        prefixIcon: Icon(
                          Icons.supervised_user_circle_rounded,
                          color: Colors.red.shade900,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
                      )),
                )
              ],
            )),
            // const SizedBox(height:,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: const Offset(1, 1),
                      color: Colors.grey.shade500.withOpacity(0.2),
                    )
                  ]),
              child: TextFormField(
                obscureText: _isHidden,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Lozinka: ",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.red.shade900,
                    ),
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? 
                        Icons.visibility : 
                        Icons.visibility_off,
                        
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0)),
                  ),
                  ),
            ),
            RichText(
              text: TextSpan(
                  text: "Nemaš korisnički račun? ",
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: " Kreiraj ovdje",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()));
                        },
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
            ),

            SizedBox(
              width: 100,
              height: 35,
              child: OutlinedButton(
                onPressed: ()  { 
                  AuthService().signIn(
                      email: emailController.text,
                      password: passwordController.text);
 
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade900,
                    side: BorderSide(
                      width: 2.0,
                      color: Colors.red.shade900,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text('Prijava'),
              ),
            ),

            Column(
              children: [
                SignInButton(Buttons.Google, onPressed: () async {
                  await AuthService().signInWithGoogle();
                  if (!mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                ),
                SignInButton(
                  Buttons.FacebookNew,
                  onPressed: ()async {
                    AuthService().signInWithFacebook();   
                    if (!mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
