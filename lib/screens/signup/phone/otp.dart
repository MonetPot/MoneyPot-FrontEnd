import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_pot/screens/navigation.dart';



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
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _otpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'OTP',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            child: Text('Verify OTP'),
            onPressed: () => _verifyOTP(),
          ),
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
            (Route<dynamic> route) => false, // Removes all the routes below the pushed route
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to verify OTP: $e');
    }
  }
}