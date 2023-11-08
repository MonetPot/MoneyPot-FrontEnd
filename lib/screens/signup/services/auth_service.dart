import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../Screens/groups/group_screen.dart';

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        // Sign in with the Google credential
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // After the sign-in is successful, navigate to the new page.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => GroupsScreen()),
        );
      }
    } catch (e) {
      // If there is an error with sign-in, handle it here
      // For example, show a Snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      // Request credential for the currently signed in Apple account.

      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      // Sign in the user with Firebase. If the user is new, a new account is created,
      // otherwise, they are signed in to their existing account.
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      // After the sign-in is successful, navigate to the GroupsScreen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => GroupsScreen()),
      );

      // Optionally, if you need to use the credential details sent back by Apple, you can do so here.
      // For example, you might want to send the `authorizationCode` to your server.
    } catch (e) {
      // Handle the error from Apple sign-in or Firebase.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Apple: $e'),
        ),
      );
    }
  }



}


