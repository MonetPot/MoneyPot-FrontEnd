import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Describe your mission here. This might include what you aim to achieve, how you plan to make a difference, or the values that drive your team.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Our Vision',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Your vision statement goes here. This could be a description of where you see your app or company in the future, the ultimate goal you are working towards, or the ideal impact you wish to have on your users or the world.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Our Team',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Introduce your team members here. You could include brief bios, roles, or interesting facts about each team member.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Add images or additional text here if needed
            // ...
          ],
        ),
      ),
    );
  }
}
