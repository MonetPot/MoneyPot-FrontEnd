import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_pot/Screens/groups/group_screen.dart';
import '../../../components/already_have_an_account.dart';
import '../../../constants.dart';
import '../../../toast.dart';
import '../../login/auth_page.dart';
import '../../login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _dateController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _dateController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null && selectedDate != DateTime.now()) {
      _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: "Your username",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _dateController,
              textInputAction: TextInputAction.next,
              readOnly: true,
              onTap: () => _selectDate(context),
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Date of Birth",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: _emailController,
            decoration: InputDecoration(

              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          signupButton("Sign Up"),
          // ElevatedButton(
          //   onPressed: () {
          //     _signUp();
          //   },
          //   child: Text("Sign Up".toUpperCase()),
          // ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _signUp() async {

    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToast(message: "User is successfully created");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return GroupsScreen();
          },
        ),
      );
    } else {
      showToast(message: "Some error happened");
    }
  }

  Widget signupButton(title) {
    return InkWell(
      onTap: () {
        _signUp();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 18.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(0.0, 32.0)),
            ],
            borderRadius: new BorderRadius.circular(36.0),
            gradient: LinearGradient(begin: FractionalOffset.centerLeft,
                stops: [
                  0.2,
                  1
                ], colors: [
                  Color(0xff000000),
                  Color(0xff434343),
                ])),
        child: Text(
          title,
          style: TextStyle(
              color: Color(0xffF1EA94),
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}