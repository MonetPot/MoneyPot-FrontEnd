import 'package:flutter/material.dart';
import '../../login/login_screen.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Hero(
            tag: "reset_password_field",
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Hero(
            tag: "confirm_password_field",
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Hero(
            tag: "next_btn",
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement your reset password logic here
              },
              style: ElevatedButton.styleFrom(primary: Colors.purple[100], elevation: 0),
              child: Text(
                "Next".toUpperCase(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16),
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
            },
            child: Text(
              "Back To Login",
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }
}