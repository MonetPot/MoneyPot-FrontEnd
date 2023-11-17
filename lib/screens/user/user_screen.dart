import 'package:flutter/material.dart';
import 'package:money_pot/Screens/settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../const/gradient.dart';

class UserScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    String userName = user?.displayName ?? 'Update Name';
    String userEmail = user?.email ?? 'Update Email';
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: userScreenGradient),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(gradient: userScreenGradient),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(

                  radius: 50,
                  backgroundImage: AssetImage('assets/images/edsheeran.png'),
                ),
                SizedBox(height: 10),
                Text(userName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(userEmail, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [Text('50 friends', style: TextStyle(fontWeight: FontWeight.bold)), Icon(Icons.people)]),
                    Column(children: [Text('5 groups', style: TextStyle(fontWeight: FontWeight.bold)), Icon(Icons.group_work)]),
                  ],
                ),
                SizedBox(height: 20),
                Text('MoneyPots', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/edsheeran.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/edsheeran.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text('Transactions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage('assets/images/edsheeran.png')),
                  title: Text("$userName, Friday Night"),
                  subtitle: Text('June 14, 2023'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('\$83.78', style: TextStyle(fontWeight: FontWeight.bold)), Text('Withdrawal')],
                  ),
                ),
                  ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage('assets/images/edsheeran.png')),
                    title: Text("$userName, Friday Night"),
                    subtitle: Text('June 14, 2023'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('\$83.78', style: TextStyle(fontWeight: FontWeight.bold)), Text('Withdrawal')],
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage('assets/images/edsheeran.png')),
                    title: Text("$userName, Friday Night"),
                    subtitle: Text('June 14, 2023'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('\$83.78', style: TextStyle(fontWeight: FontWeight.bold)), Text('Withdrawal')],
                    ),
                  ),
              ],
            ),
          ),
      ),
    );
  }
}