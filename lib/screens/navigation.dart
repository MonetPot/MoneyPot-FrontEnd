


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_pot/Screens/settings/settings_screen.dart';
import 'package:money_pot/screens/groups/add_group.dart';
import 'package:money_pot/screens/main_screen.dart';
import 'package:money_pot/screens/user/user_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onNavBarTapped(int index) {
    if (index == 1) {
      _openAddGroupScreen(context);
    } else {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openAddGroupScreen(BuildContext context) {
    Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddGroup(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          MainScreen(),
          AddGroup(),
          UserScreen(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            primaryColor: Colors.red,
            // If BottomNavigationBarType.shifting, this is the color of the selected item
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(
              caption: TextStyle(color: Colors
                  .yellow), // Color for the 'unselected' item labels
            )),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // Set the type to fixed for consistent background color
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          // Changed to white for better visibility
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_2_rounded),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.emoji_people_rounded),
            //   label: 'Friends',
            // ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage("assets/images/edsheeran.png"),
              ),
              label: 'Profile',
            ),
            // ... Add other items if needed
          ],
          currentIndex: _selectedIndex,
          onTap: _onNavBarTapped,
        ),
      ),
    );
  }
}

