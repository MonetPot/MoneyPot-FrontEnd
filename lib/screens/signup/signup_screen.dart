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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _dateController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool isSigningUp = false;

  @override
  void dispose() {
    _dateController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
            return Navigation();
          },
        ),
      );
    } else {
      showToast(message: "Some error happened");
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
        padding: EdgeInsets.only(top: 64.0),
        decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Center(
            //   child: Image.asset(
            //     'assets/icons/login.svg',
            //     width: 100.0,
            //     height: 100.0,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/signup.svg',
                width: 100.0,
                height: 100.0,
              ),
            ),
            headlinesWidget(),
            _usernameTextField(),
            _emailTextField(),
            _passwordTextField(),
             // _dateTextField(context),
            SignUpButtonWidget(),
            SocialSignUp(),
            loginWidget(context),
            // signupWidget(context)
            // signupButton("Sign Up"), // Assuming this is a custom button widget
            const SizedBox(height: defaultPadding),
            // AlreadyHaveAnAccountCheck(
            //   login: false,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => LoginScreen(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }


  Widget headlinesWidget() {
    return Container(
      margin: EdgeInsets.only(left: 48.0, top: 32.0),
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
          // Container(
          //   margin: EdgeInsets.only(top: 48.0),
          //   child: Text(
          //     'Log in \nto continue.',
          //     textAlign: TextAlign.left,
          //     style: TextStyle(
          //       letterSpacing: 3,
          //       fontSize: 32.0,
          //       fontFamily: 'Montserrat',
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }


  Widget _buildGradientTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
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
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Color(0xff35AA90), size: 10.0)
              : null,
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

  Widget _usernameTextField() {
    return _buildGradientTextField(
      controller: _usernameController,
      hintText: 'Username',
      focusNode: _usernameFocusNode,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _usernameFocusNode, _emailFocusNode);
      },
      // You can provide the specific icon you need here
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
      suffixIcon: IconData(
          0xe902, fontFamily: 'Icons'), // Change this as needed
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
      obscureText: true, // to hide the password input
      // You can provide the specific icon you need here
    );
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    // This is a small delay after unfocusing the current focus node before focusing the next one.
    // This ensures the focus node has completely unfocused before attempting to focus the next node.
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(nextFocus);
    });
  }

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


  Widget loginWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 48.0, top: 20.0),
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
      margin: EdgeInsets.only(left: 32.0, top: 32.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: isSigningUp ? null : _signUp,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
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
// Add one stop for each color. Stops should increase from 0 to 1
                      stops: [
                        0.2,
                        1
                      ], colors: [
                        Color(0xff000000),
                        Color(0xff434343),
                      ])),
              child: Text(
                'REGISTER',
                style: TextStyle(
                    color: Color(0xffF1EA94),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




/// OLD CODE


//   @override
//   Widget build(BuildContext context) {
//     return const Background(
//       child: SingleChildScrollView(
//         child: Responsive(
//           mobile: MobileSignupScreen(),
//           desktop: Row(
//             children: [
//               Expanded(
//                 child: SignUpScreenTopImage(),
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 450,
//                       child: SignUpForm(),
//                     ),
//                     SizedBox(height: defaultPadding / 2),
//                     SocialSignUp(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MobileSignupScreen extends StatelessWidget {
//   const MobileSignupScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         SignUpScreenTopImage(),
//         Row(
//           children: [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: SignUpForm(),
//             ),
//             Spacer(),
//           ],
//         ),
//         SocialSignUp(),
//       ],
//     );
//   }
// }
