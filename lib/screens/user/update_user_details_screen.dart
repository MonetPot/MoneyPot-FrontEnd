import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUserDetailsScreen extends StatefulWidget {
  @override
  _UpdateUserDetailsScreenState createState() => _UpdateUserDetailsScreenState();
}

class _UpdateUserDetailsScreenState extends State<UpdateUserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _newUsername = '';
  String _newEmail = '';
  String _newPassword = '';
  bool _isLoading = false;
  bool _updateUsername = false;
  bool _updateEmail = false;
  bool _updatePassword = false;

  Future<void> _updateUserDetails() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (_updateUsername) {
        await user!.updateDisplayName(_newUsername);
      }
      if (_updateEmail) {
        await user!.updateEmail(_newEmail);
      }
      if (_updatePassword && _newPassword.isNotEmpty) {
        await user!.updatePassword(_newPassword);
      }

      await _sendDetailsToBackend(user!.uid, _newUsername, _newEmail);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User details updated successfully!')));
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred!')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _sendDetailsToBackend(String userId, String username, String email) async {
    // Backend update logic...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update User Details')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text("Update Username"),
              value: _updateUsername,
              onChanged: (bool value) {
                setState(() { _updateUsername = value; });
              },
            ),
            if (_updateUsername)
              TextFormField(
                decoration: InputDecoration(labelText: 'New Username'),
                onSaved: (value) {
                  _newUsername = value!;
                },
              ),
            SwitchListTile(
              title: Text("Update Email"),
              value: _updateEmail,
              onChanged: (bool value) {
                setState(() { _updateEmail = value; });
              },
            ),
            if (_updateEmail)
              TextFormField(
                decoration: InputDecoration(labelText: 'New Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _newEmail = value!;
                },
              ),
            SwitchListTile(
              title: Text("Change Password"),
              value: _updatePassword,
              onChanged: (bool value) {
                setState(() { _updatePassword = value; });
              },
            ),
            if (_updatePassword)
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onSaved: (value) {
                  _newPassword = value!;
                },
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserDetails,
              child: Text('Update Details'),
            ),
          ],
        ),
      ),
    );
  }
}

