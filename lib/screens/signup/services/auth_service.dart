import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_pot/screens/navigation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {

      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        // Attempt to sign in the user with Firebase
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // Retrieve the Firebase ID token
        String? idToken = await userCredential.user!.getIdToken();
        // Now you can use this idToken to authenticate with your backend

        // If the user is new, link the credentials (if the email matches)
        // TO DO
        await linkCredentials(userCredential, credential);

        // After the sign-in is successful, navigate to the GroupsScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Navigation()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
    }
  }

// Sign in with Apple
  Future<void> signInWithApple(BuildContext context) async {
    try {
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      // Attempt to sign in the user with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Retrieve the Firebase ID token
      String? idToken = await userCredential.user!.getIdToken();
      // Now you can use this idToken to authenticate with your backend

      // If the user is new, link the credentials (if the email matches)
      await linkCredentials(userCredential, credential);

      // After the sign-in is successful, navigate to the GroupsScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Navigation()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Apple: $e'),
        ),
      );
    }
  }

  // Function to handle credential linking
  Future<void> linkCredentials(UserCredential userCredential, AuthCredential newCredential) async {
    final user = userCredential.user;
    if (userCredential.additionalUserInfo!.isNewUser) {
      // Check if the email is already associated with another account
      final emailSignInMethod = await FirebaseAuth.instance.fetchSignInMethodsForEmail(user!.email!);
      if (emailSignInMethod.isNotEmpty && emailSignInMethod.first != newCredential.providerId) {
        //attempt to link the credentials if email is associated with another email
        try {
          await user.linkWithCredential(newCredential);
        } catch (e) {
          // Handle error if cannot link
          print('Failed to link credentials: $e');
        }
      }
    }
  }
}



