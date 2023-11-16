import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_pot/screens/navigation.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Enter OTP'),
      // ),

        body: Container(
          decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
          child:
            Stack(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
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
                      child:
                      TextField(
                        controller: _otpController,
                        style: hintAndValueStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.confirmation_num_rounded),
                          contentPadding: EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: 'OTP',
                          hintStyle: hintAndValueStyle,
                        ),
                      ),

                      // TextField(
                      //   controller: _otpController,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(),
                      //     labelText: 'OTP',
                      //   ),
                      //   keyboardType: TextInputType.number,
                      // ),
                    ),
                    VerifyOTPButtonWidget(),
                    // ElevatedButton(
                    //   child: Text('Verify OTP'),
                    //   onPressed: () => _verifyOTP(),
                    // ),
                  ],
                ),
              ],
            )
        )
    );
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
                  gradient: LinearGradient(begin: FractionalOffset.centerLeft,
                      stops: [
                        0.2,
                        1
                      ], colors: [
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

  void _verifyOTP() async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Fluttertoast.showToast(msg: 'Phone verified successfully!');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
            (Route<
            dynamic> route) => false, // Removes all the routes below the pushed route
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to verify OTP: $e');
    }
  }
}