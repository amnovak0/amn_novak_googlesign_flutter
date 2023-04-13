import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login.dart';
import 'homepage.dart';

// GENERAL IDEA

// 1. HANDLE AUTH STATE
class AuthService {

  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        });
  }


final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> facebookSignin() async {
    try {
      final _instance = FacebookAuth.instance;
      final result = await _instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final a = await _auth.signInWithCredential(credential);
        await _instance.getUserData().then((userData) async {
          await _auth.currentUser!.updateEmail(userData['email']);
        });
        return null;
      } else if (result.status == LoginStatus.cancelled) {
        return 'Login cancelled';
      } else {
        return 'Error';
      }
    } catch (e) {
      return e.toString();
    }
  }
  
  // 2. signInWithGoogle()

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

 

  // 3. HANDLE SIGNING OUT
  signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    final GoogleSignIn googleUser = await GoogleSignIn(scopes: <String>["email"]);

    await _firebaseAuth.signOut();
    
    googleUser.signOut();
  }
  // determine if user is authenticated
}


//FACEBOOK LOGIN HANDLING
