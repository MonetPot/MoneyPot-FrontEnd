import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_pot/screens/groups/group_details.dart';
import 'package:money_pot/screens/search/search_screen.dart';

import '../const/gradient.dart';
import 'settings/settings_screen.dart';
import 'user/user_screen.dart';
import 'groups/bills/text_scanner.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                'Groups',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ),
        flexibleSpace: Container(
          decoration: groupScreenDecoration,
        ),
              actions: <Widget> [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(SlideFromLeftPageRoute(page: SearchScreen()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                  },
                ),
              ],
        backgroundColor: Colors.transparent, // Make the AppBar background transparent
        elevation: 0,
      ),
      // floatingActionButton: SpeedDial(
      //   animatedIcon: AnimatedIcons.view_list,
      //   children: [
      //     SpeedDialChild(
      //       child: Icon(Icons.camera_enhance_rounded),
      //       label: 'Scan Bill',
      //       onTap: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => TextScanner()));
      //         // Handle Option 1
      //       },
      //     ),
      //     SpeedDialChild(
      //       child: Icon(Icons.front_hand_rounded),
      //       label: 'Enter Bill Manually',
      //       onTap: () {
      //         // Handle Option 2
      //       },
      //     ),
      //   ],
      // ),
      body: Container(
        decoration: groupScreenDecoration,
        // Edit this padding to arrange the groups better
        // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: ListView(
        children: [
          Container  (
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Add Group functionality
                //     },
                //     child: Text("Add Group"),
                //   ),
                // ),
                GroupTile(
                  groupName: 'Friday Night',
                  amount: '\$700',
                  membersCount: '3 members',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GroupDetailsScreen(),
                      ),
                    );
                  },
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SettingsScreen()));
                  groupImage: AssetImage("assets/images/edsheeran.png"),
                ),
                GroupTile(
                  groupName: 'Travis Scott Concert',
                  amount: '\$1000',
                  membersCount: '5 members',
                  groupImage: AssetImage("assets/images/edsheeran.png"),
                ),
                // Other GroupTile widgets...
                GroupTile(
                  groupName: 'Vancouver Trip',
                  amount: '\$1,096',
                  membersCount: '5 members',
                  groupImage: AssetImage("assets/images/edsheeran.png"),
                ),
                GroupTile(
                  groupName: 'Trip to Japan',
                  amount: '\$0',
                  membersCount: '2 members',
                  groupImage: AssetImage("assets/images/edsheeran.png"),
                ),
                GroupTile(
                  groupName: 'Halloween in Urbana',
                  amount: '\$300',
                  membersCount: '3 members',
                  groupImage: AssetImage("assets/images/edsheeran.png"),
                ),
              ],
            ),
          )
        ],
      ),
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  final String groupName;
  final String amount;
  final String membersCount;
  final AssetImage groupImage;
  final VoidCallback? onTap;

  GroupTile({
    Key? key,
    required this.groupName,
    required this.amount,
    required this.membersCount,
    required this.groupImage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: groupImage,
                  ),
                  title: Text(groupName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(amount),
                      Text(membersCount),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality to access funds
                      },
                      child: Text("Access Funds"),
                    ),
                  ),
                ),
              ],
            ),
          ),
      )

    );
  }
}


class SlideFromLeftPageRoute extends PageRouteBuilder {
  final Widget page;
  SlideFromLeftPageRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      var begin = Offset(-1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}



