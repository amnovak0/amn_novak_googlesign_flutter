

import 'package:flutter/material.dart';
import 'package:flutter_login/homepage.dart';
import 'package:flutter_login/auth_service.dart';

// import 'facebook_auth.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //variable to hide password
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
            const Image(
              image: AssetImage('assets/hrnogomet.png'),
              width: 200,
              height: 150,
            ),
            SizedBox(
                child: Column(
              children: [
                Text(
                  "Registracija",
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
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
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: ("Ime: "),
                        prefixIcon: Icon(
                          Icons.supervised_user_circle_outlined,
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
                ),
              ],
            )),
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
                    hintText: "Email: ",
                    prefixIcon: Icon(
                      Icons.email_outlined,
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
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0)),
                  )),
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
                        // Icons.password,
                        color: Colors.red.shade900,
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
            SizedBox(
              width: 170,
              height: 45,
              child: OutlinedButton(
                onPressed: () {
                  AuthService()
                      .signUp(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((result) {
                    if (result != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Try again')));
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade900,
                    side: BorderSide(
                      width: 2.0,
                      color: Colors.red.shade900,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'Registracija',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
