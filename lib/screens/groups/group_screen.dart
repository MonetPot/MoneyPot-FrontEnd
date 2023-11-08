import 'package:flutter/material.dart';

import '../settings/settings_screen.dart';
import '../user/user_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.arrow_back_ios),
      //   title: Text("Groups"),
      //   actions: [Icon(Icons.settings)],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add group functionality
      //   },
      //   child: Icon(Icons.add),
      // ),
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
                  backgroundColor: Theme.of(context).primaryColor,
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
                  'Groups',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // Action Icon
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add Group functionality
              },
              child: Text("Add Group"),
            ),
          ),
          GroupTile(
            groupName: 'Friday Night',
            amount: '\$700',
            membersCount: '3 members',
            groupImage: AssetImage("assets/images/edsheeran.png"),
          ),
          GroupTile(
            groupName: 'Travis Scott Concert',
            amount: '\$1000',
            membersCount: '5 members',
            groupImage: AssetImage("assets/images/edsheeran.png"),
          ),
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

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: AssetImage("assets/images/edsheeran.png"),
            ),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserScreen()),
            );
          }
        },
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  final String groupName;
  final String amount;
  final String membersCount;
  final AssetImage groupImage;

  GroupTile({
    Key? key,
    required this.groupName,
    required this.amount,
    required this.membersCount,
    required this.groupImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}