import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_pot/Screens/groups/group_screen.dart';
import '../../../components/already_have_an_account.dart';
import '../../../constants.dart';
import '../../../toast.dart';
import '../../login/auth_page.dart';
import '../../login/login_screen.dart';
import 'package:money_pot/screens/widgets/date_picker.dart';
import 'package:money_pot/const/gradient.dart';
import 'package:money_pot/const/styles.dart';

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
          _usernameTextField(),
          _dateTextField(context),
          _emailTextField(),
          _passwordTextField(),
          const SizedBox(height: defaultPadding / 2),
          signupButton("Sign Up"), // Assuming this is a custom button widget
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget _buildTextInputField({
  //   required TextEditingController controller,
  //   required IconData icon,
  //   required String hintText,
  //   bool isPassword = false,
  //   TextInputType keyboardType = TextInputType.text,
  //   TextInputAction textInputAction = TextInputAction.next,
  //   VoidCallback? onTap,
  //   bool readOnly = false,
  // }) {
  //   return TextFormField(
  //     controller: controller,
  //     cursorColor: kPrimaryColor,
  //     obscureText: isPassword,
  //     keyboardType: keyboardType,
  //     textInputAction: textInputAction,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       prefixIcon: Padding(
  //         padding: const EdgeInsets.all(defaultPadding),
  //         child: Icon(icon),
  //       ),
  //     ),
  //     onTap: onTap,
  //     readOnly: readOnly,
  //   );
  // }

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

  Widget _buildGradientTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 32.0, top: 32.0),
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
      ),
    );
  }


  Widget _emailTextField() {
    return _buildGradientTextField(
      controller: _emailController,
      hintText: 'Email',
      suffixIcon: IconData(0xe902, fontFamily: 'Icons'), // Change this as needed
    );
  }

  Widget _usernameTextField() {
    return _buildGradientTextField(
      controller: _usernameController,
      hintText: 'Username',
      // You can provide the specific icon you need here
    );
  }

  Widget _passwordTextField() {
    return _buildGradientTextField(
      controller: _passwordController,
      hintText: 'Password',
      obscureText: true, // to hide the password input
      // You can provide the specific icon you need here
    );
  }

// Then, you create the date text field like this:
  Widget _dateTextField(BuildContext context) {
    return _buildGradientTextField(
      controller: _dateController,
      hintText: 'Date of Birth',
      suffixIcon: Icons.calendar_today, // Change this as needed
      keyboardType: TextInputType.none, // To prevent the keyboard from showing up
      onTap: () {
        // Prevent the focus from going to the text field (and hence, opening the keyboard)
        FocusScope.of(context).requestFocus(new FocusNode());
        // Call the method to show the date picker dialog.
        _selectDate(context);
      },
    );
  }





  // Widget passwordTextFieldWidget() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 32.0, right: 16.0),
  //     child: TextField(
  //       controller: _passwordController,
  //       style: hintAndValueStyle,
  //       obscureText: true,
  //       decoration: new InputDecoration(
  //           fillColor: Color(0x3305756D),
  //           filled: true,
  //           contentPadding: new EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
  //           border: OutlineInputBorder(
  //               borderRadius: new BorderRadius.circular(12.0),
  //               borderSide: BorderSide.none),
  //           hintText: 'Password',
  //           hintStyle: hintAndValueStyle),
  //     ),
  //   );
  // }

  // Widget emailTextFieldWidget() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 16.0, right: 32.0, top: 32.0),
  //     decoration: BoxDecoration(
  //         boxShadow: [
  //           BoxShadow(
  //               color: Colors.black12,
  //               blurRadius: 15,
  //               spreadRadius: 0,
  //               offset: Offset(0.0, 16.0)),
  //         ],
  //         borderRadius: new BorderRadius.circular(12.0),
  //         gradient: LinearGradient(
  //             begin: FractionalOffset(0.0, 0.4),
  //             end: FractionalOffset(0.9, 0.7),
  //             // Add one stop for each color. Stops should increase from 0 to 1
  //             stops: [
  //               0.2,
  //               0.9
  //             ],
  //             colors: [
  //               Color(0xffFFC3A0),
  //               Color(0xffFFAFBD),
  //             ])),
  //     child: TextField(
  //       controller: _emailController,
  //       style: hintAndValueStyle,
  //       decoration: new InputDecoration(
  //           suffixIcon: Icon(IconData(0xe902, fontFamily: 'Icons'),
  //               color: Color(0xff35AA90), size: 10.0),
  //           contentPadding: new EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
  //           border: OutlineInputBorder(
  //               borderRadius: new BorderRadius.circular(12.0),
  //               borderSide: BorderSide.none),
  //           hintText: 'Email',
  //           hintStyle: hintAndValueStyle),
  //     ),
  //   );
  // }

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