import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_pot/Screens/login/login_screen.dart';
import 'package:money_pot/const/color_const.dart';
import 'package:money_pot/const/gradient.dart';
import 'package:money_pot/screens/user/update_user_details_screen.dart';
import 'package:money_pot/screens/settings/about_us.dart';
import 'package:money_pot/screens/settings/privacy_policy.dart';
import 'package:money_pot/screens/settings/terms_and_conditions.dart';

class SettingsScreen extends StatelessWidget {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container (
          decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                      Center(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    // ),
                    // Title
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    // Action Icon
                    IconButton(
                      icon: Icon(Icons.exit_to_app,
                      color: TEXT_BLACK),
                      color: Colors.white,
                      onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // Navigator.of(context).pushReplacementNamed('/sign-in');

                    // If you haven't defined named routes, use MaterialPageRoute directly as below:
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(), // Make sure you have imported LoginScreen at the top
                    ));
                    },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Update user info'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserDetailsScreen()));
                },
              ),
              // ListTile(
              //   title: Text('Change password'),
              //   trailing: Icon(Icons.arrow_forward_ios),
              //   onTap: () {
              //     // Handle change password logic
              //   },
              // ),
              ListTile(
                title: Text('Add a payment method'),
                trailing: Icon(Icons.add),
                onTap: () {
                  // Handle add a payment method logic
                },
              ),
              SwitchListTile(
                title: Text('Push notifications'),
                value: true,
                onChanged: (bool value) {
                  // Handle push notifications toggle logic
                },
              ),
              // SwitchListTile(
              //   title: Text('Dark mode'),
              //   value: false,
              //   onChanged: (bool value) {
              //     // Handle dark mode toggle logic
              //   },
              // ),
              Divider(),
              ListTile(
                title: Text('About us'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutUsScreen(),
                  ));
                },
              ),
              ListTile(
                title: Text('Privacy policy'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ));
                },
              ),
              ListTile(
                title: Text('Terms and conditions'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TermsAndConditionsScreen(),
                  ));
                },
              ),
              ListTile(
                title: Text('Sign out'),
                trailing: Icon(Icons.exit_to_app),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // Navigator.of(context).pushReplacementNamed('/sign-in');


                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
              ),
            ],
          ),
        ),
    );
  }
}