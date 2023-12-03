import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_pot/constants.dart';
import 'package:money_pot/screens/navigation.dart';
import '../../Screens/login/auth_login_page.dart';
import '../../Screens/login/login_screen.dart';
import '../../toast.dart';
import 'package:money_pot/const/gradient.dart';
import 'package:money_pot/const/styles.dart';
import 'components/social_signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _dateController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _firstnameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool isSigningUp = false;

  @override
  void dispose() {
    _dateController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _firstnameFocusNode.dispose();
    _lastnameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String firstName = _firstnameController.text;
    String lastName = _lastnameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String firebaseUid = userCredential.user!.uid;
      User? user = userCredential.user;

      if (user != null) {
        String displayName = '$firstName $lastName';

        await user.updateDisplayName(displayName);


        await user.reload();


        var response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/users/create'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'password': password,
            'firebase_id': firebaseUid,
          }),
        );

        if (response.statusCode == 200) {
          showToast(message: "User is successfully created");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Navigation()),
                (Route<dynamic> route) => false,
          );
        } else {
          showToast(message: "Failed to create user: ${response.body}");
        }
      }



    } catch (e) {
      showToast(message: "Error: $e");
    } finally {
      setState(() {
        isSigningUp = false;
      });
    }
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                'assets/icons/signup.svg',
                width: 100.0,
                height: 100.0,
              ),
            ),
            headlinesWidget(),
            _firstNameTextField(),
            _lastNameTextField(),
            _emailTextField(),
            _passwordTextField(),
            // _dateTextField(context),
            SignUpButtonWidget(),
            SocialSignUp(),
            loginWidget(context),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }


  Widget headlinesWidget() {
    return Container(
      margin: EdgeInsets.only(left: 35.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Register an account',
            textAlign: TextAlign.left,
            style: TextStyle(
                letterSpacing: 3,
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  Widget _buildGradientTextField({
    required TextEditingController controller,
    required String hintText,
    required Icon suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
    required FocusNode focusNode,
    Function(String)? onFieldSubmitted,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(0.0, 16.0),
          ),
        ],
        borderRadius: new BorderRadius.circular(12.0),
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.4),
          end: FractionalOffset(0.9, 0.7),
          stops: [0.2, 0.9],
          colors: [
            Color(0xffFFC3A0),
            Color(0xffFFAFBD),
          ],
        ),
      ),
      child: TextField(
        controller: controller,
        style: hintAndValueStyle,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: onTap != null,
        onTap: onTap,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: hintAndValueStyle,
        ),
        onSubmitted: onFieldSubmitted,
      ),
    );
  }

  Widget _firstNameTextField() {
    return _buildGradientTextField(
        controller: _firstnameController,
        hintText: 'Name',
        focusNode: _firstnameFocusNode,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _firstnameFocusNode, _emailFocusNode);
        },
        suffixIcon: Icon(Icons.abc_rounded)
    );
  }

  Widget _lastNameTextField() {
    return _buildGradientTextField(
        controller: _lastnameController,
        hintText: 'Last Name',
        focusNode: _lastnameFocusNode,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _lastnameFocusNode, _emailFocusNode);
        },
        suffixIcon: Icon(Icons.abc_rounded)
    );
  }


  Widget _emailTextField() {
    return _buildGradientTextField(
      controller: _emailController,
      hintText: 'Email',
      focusNode: _emailFocusNode,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
      },
      suffixIcon: Icon(Icons.alternate_email_rounded),
    );
  }

  Widget _passwordTextField() {
    return _buildGradientTextField(
      controller: _passwordController,
      hintText: 'Password',
      focusNode: _passwordFocusNode,
      onFieldSubmitted: (term) {
        _passwordFocusNode.unfocus();
      },
      obscureText: true,
      suffixIcon: Icon(Icons.password_rounded),
    );
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(nextFocus);
    });
  }

  Widget loginWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 48.0),
      child: Row(
        children: <Widget>[
          Text(
            'Already have an account?',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
              // print('Sign Up button pressed');
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff353535),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          )
        ],
      ),
    );
  }

  Widget SignUpButtonWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
      padding: EdgeInsets.symmetric(horizontal: 36.0),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(36.0),
        gradient: LinearGradient(
          begin: FractionalOffset.centerLeft,
          stops: [0.2, 1],
          colors: [
            Color(0xff000000),
            Color(0xff434343),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(0.0, 32.0),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isSigningUp ? null : _signUp,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
          ),
          onPrimary: Color(0xffF1EA94), // Text color
        ),
        child: Text(
          'REGISTER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}

// PREVIOUS SIGNUP FUNCTION
// void _signUp() async {
//   setState(() {
//     isSigningUp = true;
//   });
//
//   String firstName = _firstnameController.text;
//   String lastName = _lastnameController.text;
//   String email = _emailController.text;
//   String password = _passwordController.text;
//
//   String fullName = firstName + " " + lastName;
//
//   User? user = await _auth.signUpWithEmailAndPassword(email, password);
//
//   setState(() {
//     isSigningUp = false;
//   });
//   if (user != null) {
//     await user.updateDisplayName(fullName);
//     showToast(message: "User is successfully created");
//     if (!mounted) return;
//
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => Navigation()),
//           (Route<dynamic> route) => false,
//     );
//   }
// }



// PREVIOUS SIGN UP

// Future<void> sendUserDataToBackend(User user) async {
//   String firstName = _firstnameController.text;
//   String lastName = _lastnameController.text;
//   print('here');
//   final url = Uri.parse('http://127.0.0.1:8000/api/user/create');
//   final response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({
//       'firebase_id': user.uid,
//       'email': user.email,
//       'first_name': firstName,
//       'last_name': lastName,
//     }),
//   );
//   print('here2');
//   if (response.statusCode == 200) {
//     showToast(message: "User successfully registered in backend");
//     Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation()));
//   } else {
//     showToast(message: "Backend registration failed");
//     //user deletion if backend registration fails
//   }
// }
//
// void _signUp() async {
//   setState(() {
//     isSigningUp = true;
//   });
//
//   String email = _emailController.text;
//   String password = _passwordController.text;
//
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//
//     User? user = userCredential.user;
//     if (user != null) {
//       await sendUserDataToBackend(user);
//     }
//   } on FirebaseAuthException catch (e) {
//     showToast(message: "Firebase Error: ${e.message}");
//   } catch (e) {
//     showToast(message: "Error: $e");
//   } finally {
//     setState(() {
//       isSigningUp = false;
//     });
//   }
// }


//   Widget _dateTextField(BuildContext context) {
//     return _buildGradientTextField(
//       controller: _dateController,
//       hintText: 'Date of Birth',
//       suffixIcon: Icons.calendar_today,
//       // Change this as needed
//       keyboardType: TextInputType.none,
//       // To prevent the keyboard from showing up
//       onTap: () {
//         // Prevent the focus from going to the text field (and hence, opening the keyboard)
//         FocusScope.of(context).requestFocus(new FocusNode());
//         // Call the method to show the date picker dialog.
//         _selectDate(context);
//       },
//     );
//   }

//   Widget SignUpButtonWidget() {
//     return Container(
//       margin: EdgeInsets.only(left: 32.0, top: 32.0),
//       child: Row(
//         children: <Widget>[
//           InkWell(
//             onTap: isSigningUp ? null : _signUp,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 13.0),
//               decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 15,
//                         spreadRadius: 0,
//                         offset: Offset(0.0, 32.0)),
//                   ],
//                   borderRadius: new BorderRadius.circular(36.0),
//                   gradient: LinearGradient(begin: FractionalOffset.centerLeft,
//                       stops: [
//                         0.2,
//                         1
//                       ], colors: [
//                         Color(0xff000000),
//                         Color(0xff434343),
//                       ])),
//               child: Text(
//                 'REGISTER',
//                 style: TextStyle(
//                     color: Color(0xffF1EA94),
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Montserrat'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }