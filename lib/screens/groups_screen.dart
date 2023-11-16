import 'package:flutter/material.dart';
import 'package:money_pot/screens/funds/access_funds.dart';
import 'package:money_pot/screens/group/group_details.dart';
import 'package:money_pot/screens/search/search_screen.dart';

// import '../const/gradient.dart';
import '../const/gradient.dart';
import 'settings/settings_screen.dart';


// Define the gradient colors here
const Color GREEN = Color(0xFFa8e063);
const Color BLUE_DEEP = Color(0xFF515bd4);

// Gradient decoration used in the AppBar and the body's background
final BoxDecoration groupScreenDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: FractionalOffset(0.0, 0.5),
    end: FractionalOffset(0.9, 0.7),
    stops: [0.1, 0.5],
    colors: [GREEN, BLUE_DEEP],
  ),
);

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
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
          decoration: BoxDecoration(gradient: groupScreenGradient),
        ),
              actions: <Widget> [
                IconButton(
                  icon: Icon(Icons.search),
                  color: Theme
                      .of(context)
                      .primaryColor,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        decoration: BoxDecoration(gradient: groupScreenGradient),
        child: ListView(
        children: [
          Container  (
            child: Column(
              children: [
                SizedBox(height: 25),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AccessFunds(),
                          ),
                        );
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



