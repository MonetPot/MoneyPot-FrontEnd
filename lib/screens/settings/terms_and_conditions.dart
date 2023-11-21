import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Introduction',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'These Terms and Conditions govern your use of our app and services. By accessing or using the app, you agree to be bound by these terms.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              'Use of the App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Detail the permissible ways in which your app can be used, along with any prohibited activities.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              'Account Registration and Use',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Describe the process of account registration and any rules or obligations related to account management.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              'Intellectual Property Rights',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'State the ownership of content within the app and the rights of users regarding intellectual property.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              'User Content',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Outline guidelines and policies regarding any content users may create or upload to the app.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              'Termination of Use',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Explain the conditions under which a user’s access to the app may be terminated.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              'Limitation of Liability',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Include a clause that limits your liability in cases where your app may malfunction, cause loss or damage.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              'Changes to Terms',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Inform users that the Terms and Conditions may be updated periodically and how they will be notified of these changes.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            // Include other sections as necessary
            // ...

            Text(
              'Contact Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Provide information on how users can contact you for any questions or concerns about the terms.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
