import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:money_pot/screens/group/add_group.dart';
import 'package:money_pot/screens/group/groups_screen.dart';
import 'package:money_pot/screens/user/user_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  bool isFABOpen = false;
  AnimationController? _fabAnimationController;
  Animation<double>? _fabAnimation;

  // final user = FirebaseAuth.instance.currentUser;
  // final userEmail = user?.email ?? '';
  String? userIdentifier;

  void _onNavBarTapped(int index) {
    // if (index == 1) {
    //   _openAddGroupScreen(context);
    // } else {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userIdentifier = user?.uid;
      print(userIdentifier);
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

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
          GroupsScreen(identifier: userIdentifier!),
          // AddGroup(),
          UserScreen(),
        ],
      ),
      floatingActionButton: ExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme.copyWith(
                  bodySmall: TextStyle(color: Colors.yellow),
                )),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_2_rounded),
              label: 'Groups',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.add),
            //   label: 'Add',
            // ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/edsheeran.png"), // Change to user picture
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onNavBarTapped,
        ),
      ),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget _buildOption(IconData icon, double angle, double distance) {
    final double rad = angle * (math.pi / 180.0);
    final double dx = math.cos(rad) * distance;
    final double dy = math.sin(rad) * distance;
    return Positioned(
      bottom: 56.0 + dy * _animation.value, // 56.0 is the default FAB size
      right: (MediaQuery.of(context).size.width / 2 - 56.0 / 2) -
          dx * _animation.value,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(dx * (1 - _animation.value), dy * (1 - _animation.value)),
        child: Opacity(
          opacity: _animation.value,
          child: CircularButton(
            color: _animation.value > 0
                ? Colors.blue
                : Colors.grey.shade800, // Change color when visible
            width: 40,
            height: 40,
            icon: Icon(icon, color: Colors.white),
            onClick: () {
              // Add your onPressed functionality
              _toggle(); // Optionally close the FAB menu
            },
          ),
        ),
      ),
    );
  }

  // Widget _buildOption(IconData icon, double angle, double distance) {
  //   final double rad = angle * (pi / 180.0);
  //   final double dx = cos(rad) * distance;
  //   final double dy = sin(rad) * distance;
  //   return Positioned(
  //     bottom: 56.0 + (dy * _animation.value), // 56.0 is the default FAB size
  //     right: (MediaQuery.of(context).size.width / 2 - 56.0 / 2) -
  //         (dx * _animation.value),
  //     child: Transform(
  //       transform: Matrix4.identity()
  //         ..translate(
  //           (dx * _animation.value),
  //           (dy * _animation.value),
  //         ),
  //       child: Opacity(
  //         opacity: _animation.value,
  //         child: CircularButton(
  //           color: Colors.grey.shade800,
  //           width: 40,
  //           height: 40,
  //           icon: Icon(
  //             icon,
  //             color: Colors.white,
  //           ),
  //           onClick: () {
  //             // Add your onPressed functionality
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        _buildTapToCloseFab(),
        _buildOption(
            Icons.text_fields, 180.0, 100), // Positioned left from the FAB
        _buildOption(Icons.image, 0.0, 100), // Positioned right from the FAB
      ],
    );
  }

  Widget _buildTapToCloseFab() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: _toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform(
            transform:
                Matrix4.rotationZ(_controller.value * 0.5 * 3.1415926535897932),
            alignment: FractionalOffset.center,
            child: Icon(_controller.isDismissed ? Icons.add : Icons.close),
          );
        },
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final VoidCallback onClick;

  CircularButton({
    required this.color,
    required this.width,
    required this.height,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
        if (color == Colors.blue) // Shadow appears when the button is blue
          BoxShadow(
            color: Colors.blueAccent,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
      ]),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        onPressed: onClick,
      ),
    );
  }
}
