import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_pot/screens/navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../const/gradient.dart';
import '../../../const/styles.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String verificationId;

  OTPVerificationScreen({required this.verificationId});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Enter OTP'),
        // ),

        body: Container(
            decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
            child: Stack(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    headlinesWidget(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _otpController,
                        style: hintAndValueStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.confirmation_num_rounded),
                          contentPadding:
                              EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: 'OTP',
                          hintStyle: hintAndValueStyle,
                        ),
                      ),
                    ),
                    VerifyOTPButtonWidget(),
                  ],
                ),
              ],
            )));
  }

  Widget VerifyOTPButtonWidget() {
    return Container(
      margin: EdgeInsets.only(left: 32.0, top: 32.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => _verifyOTP(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 13.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: Offset(0.0, 32.0)),
                  ],
                  borderRadius: new BorderRadius.circular(36.0),
                  gradient: LinearGradient(
                      begin: FractionalOffset.centerLeft,
                      stops: [
                        0.2,
                        1
                      ],
                      colors: [
                        Color(0xff000000),
                        Color(0xff434343),
                      ])),
              child: Text(
                'VERIFY',
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

  Widget headlinesWidget() {
    return Container(
      margin: EdgeInsets.only(left: 48.0, top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Enter OTP',
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

  Future<void> _promptUserForDetails(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Complete Your Profile'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                nameTextField(),
                emailTextFieldWidget(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Skip'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                _updateFirebaseUserDetails(
                    _nameController.text, _emailController.text, context);
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
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
      margin: EdgeInsets.only(left: 20.0, right: 30.0, top: 15.0),
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

  Widget nameTextField() {
    return _buildGradientTextField(
        controller: _nameController,
        hintText: 'Name',
        focusNode: _nameFocusNode,
        onFieldSubmitted: (term) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        suffixIcon: Icon(Icons.abc_rounded));
  }

  Widget emailTextFieldWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 32.0, top: 32.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(0.0, 16.0)),
          ],
          borderRadius: new BorderRadius.circular(12.0),
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.4),
              end: FractionalOffset(0.9, 0.7),
              stops: [
                0.2,
                0.9
              ],
              colors: [
                Color(0xffFFC3A0),
                Color(0xffFFAFBD),
              ])),
      child: TextField(
        controller: _emailController,
        style: hintAndValueStyle,
        // onSubmitted: (value) {
        //   _emailFocusNode.unfocus();
        // },
        decoration: new InputDecoration(
            suffixIcon: Icon(Icons.email_rounded),
            contentPadding: new EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: 'Email',
            hintStyle: hintAndValueStyle),
      ),
    );
  }

  void _verifyOTP() async {
    String name = _nameController.text;
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      Fluttertoast.showToast(msg: 'Phone verified successfully!');

      User? user = userCredential.user;
      if (user != null) {
        // await _promptUserForDetails(context);
        String name = _nameController.text;
        List<String> nameParts = name.split(' ');
        String firstName = nameParts.first;
        String lastName = nameParts.length > 1 ? nameParts.last : '';
        String email = _emailController.text;
        // await user.updateDisplayName(name);
        // await user.updateEmail(email);

        var response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/users/create'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            if (firstName.isNotEmpty) 'first_name': firstName,
            if (lastName.isNotEmpty) 'last_name': lastName,
            if (email.isNotEmpty) 'email': email,
            'firebase_id': user.uid,
            'phone_number': user.phoneNumber,
          }),
        );

        if (response.statusCode == 200) {
          // Fluttertoast.showToast(msg: 'User created successfully!');
          // Proceed with navigation or other logic
        } else {
          Fluttertoast.showToast(
              msg: 'Failed to create user: ${response.body}');
        }

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Navigation()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to verify OTP: $e');
    }
  }

  void _updateFirebaseUserDetails(
      String name, String email, BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.updateEmail(email);
      // _updateBackendUserDetails(user.uid, name, email);
    }
  }
}
