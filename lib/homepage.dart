import 'dart:convert';

import 'api/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/login.dart';
import 'auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
 const  HomePage({Key? key}) : super(key : key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  // late Future<Album> futureAlbum;
  // @override
  // void initState() {
  //   super.initState();
  //   futureAlbum = fetchAlbum();
  // }

  late String email;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
               ("${FirebaseAuth.instance.currentUser!.displayName}"),
                 style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),

            ), 
            const SizedBox(
              height: 10,
            ),
            Text(
              ("${FirebaseAuth.instance.currentUser!.email}"),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 30,
            ),

            // FutureBuilder<Album>(
            //   future: futureAlbum,
            //   builder: (context, snapshot) {
            //     if(snapshot.hasData) {
            //        return Text(snapshot.data!.email); 
            //     }
            //     else if(snapshot.hasError) 
            //     {
            //       return Text('${snapshot.error}');
            //     }
            //     return const CircularProgressIndicator();
            //   },
            // ),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.red.shade900,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'LOG OUT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () async {
                await AuthService().signOut();
                print("User signed out");
                if (!mounted) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
