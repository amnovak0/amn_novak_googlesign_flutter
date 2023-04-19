import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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
            // INSTEAD OF LOGIN PAGE... FOR NOW
          }
        });
  }



  //SIGN IN WITH FACEBOOK
  signInWithFacebook() async {
    final fb = FacebookLogin();
    // Log in
    final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
    ]);
    // Check result status
    switch (res.status) {
        case FacebookLoginStatus.success:
        // The user is suceessfully logged in
        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken!.token);
        final result = await FirebaseAuth.instance.signInWithCredential(authCredential);
        // Get profile data from facebook for use in the app
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        // fetch user email
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        break;
        case FacebookLoginStatus.cancel:
            // In case the user cancels the login process
            break;
        case FacebookLoginStatus.error:
        // Login procedure failed
        print('Error while log in: ${res.error}');
        break;
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
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final GoogleSignIn googleUser =  GoogleSignIn(scopes: <String>["email"]);

    await firebaseAuth.signOut();
    
    googleUser.signOut();
  }
  // determine if user is authenticated

  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

   //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  
 }




