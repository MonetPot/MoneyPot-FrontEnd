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
  String? userIdentifier;

  void _onNavBarTapped(int index) {
    // Handling the middle tab differently
    if (index == 1) {
      // This is where you can handle the middle tab press, if necessary
    } else {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userIdentifier = user.uid;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showAction(BuildContext context, int index) {
    // Your action code here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: <Widget>[
          GroupsScreen(identifier: userIdentifier!),
          Container(), // Placeholder for the second tab
          UserScreen(),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 90.0,
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.group_add_rounded),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.camera_alt_rounded),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme.copyWith(
                  bodySmall: TextStyle(color: Colors.yellow),
                )),
        child: BottomAppBar(
          color: Colors.black,
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                iconSize: 35,
                icon: Icon(
                  Icons.groups_2_rounded,
                  color: Colors.white,
                ),
                onPressed: () => _onNavBarTapped(0),
              ),
              // The second IconButton should be removed or repositioned since the FAB will be in the center.
              IconButton(
                iconSize: 35.0,
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () => _onNavBarTapped(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  final double distance;
  final List<Widget> children;

  const ExpandableFab({
    Key? key,
    required this.distance,
    required this.children,
  }) : super(key: key);

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return IgnorePointer(
      ignoring: !_open,
      child: AnimatedOpacity(
        opacity: _open ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: FloatingActionButton(
          onPressed: _toggle,
          child: const Icon(Icons.close),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    // print(widget.distance);
    final step = count > 1 ? 180 / (count - 1) : 0;
    for (var i = 0,
            angleInDegrees = -90.0; // Start from -90 degrees to spread upwards
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          index: i,
          //directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedOpacity(
        opacity: _open ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 250),
        child: FloatingActionButton(
          onPressed: _toggle,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  final int index;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  const _ExpandingActionButton({
    Key? key,
    required this.index, // Accept the index parameter
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final fabSize = 56; // Default FAB size, adjust if yours is different
        final fabHorizontalPosition = screenWidth / 2 - fabSize / 2 + 40;
        final fabVerticalPosition = 56.0; // Adjust if necessary for your layout

        // Use the index to calculate the horizontal offset
        final double dx = (index - 1) *
            (fabSize + 20.0) *
            progress.value; // Spacing of 8.0 between buttons
        final double dy =
            -progress.value * maxDistance; // Negative for upwards movement

        return Positioned(
          bottom: fabVerticalPosition + 50,
          left: fabHorizontalPosition + dx,
          child: Opacity(
            opacity: progress.value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: icon,
    );
  }
}
