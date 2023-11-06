import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account.dart';
import '../../../constants.dart';
import '../../../toast.dart';
import '../../groups/group_screen.dart';
import '../../signup/signup_screen.dart';
import '../auth_page.dart';



class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                _signIn();
              },
              //     onPressed: () {
              //         Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) => GroupsScreen()),
              //
              //       );
              child: Text(
                "Login".toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
void _signIn() async {

  setState(() {
    _isSigning = true;
  });

  String email = _emailController.text;
  String password = _passwordController.text;

  User? user = await _auth.signInWithEmailAndPassword(email, password);

  setState(() {
    _isSigning = false;
  });

  if (user != null) {
    showToast(message: "User is successfully signed in");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => GroupsScreen()),

    );
  } else {
    showToast(message: "some error occurred");
  }
}
}