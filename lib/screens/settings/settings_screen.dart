import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_pot/Screens/login/login_screen.dart';
import 'package:money_pot/screens/user/user_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Leading Icon
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,  // Adjust this color as needed
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),


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
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Change Email'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle Change Email logic
            },
          ),
          ListTile(
            title: Text('Change password'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle Change password logic
            },
          ),
          ListTile(
            title: Text('Add a payment method'),
            trailing: Icon(Icons.add),
            onTap: () {
              // Handle Add a payment method logic
            },
          ),
          SwitchListTile(
            title: Text('Push notifications'),
            value: true,
            onChanged: (bool value) {
              // Handle push notifications toggle logic
            },
          ),
          SwitchListTile(
            title: Text('Dark mode'),
            value: false,
            onChanged: (bool value) {
              // Handle dark mode toggle logic
            },
          ),
          Divider(),
          ListTile(
            title: Text('About us'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle About us logic
            },
          ),
          ListTile(
            title: Text('Privacy policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle Privacy policy logic
            },
          ),
          ListTile(
            title: Text('Terms and conditions'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle Terms and conditions logic
            },
          ),
          ListTile(
            title: Text('Sign out'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              // Use the following line if you have defined the route '/sign-in' in your route table.
              // Navigator.of(context).pushReplacementNamed('/sign-in');

              // If you haven't defined named routes, use MaterialPageRoute directly as below:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(), // Make sure you have imported LoginScreen at the top
              ));
            },
          ),
        ],
      ),

    );
  }
}