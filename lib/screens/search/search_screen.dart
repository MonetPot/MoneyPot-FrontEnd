import 'package:flutter/material.dart';

import '../../Screens/settings/settings_screen.dart';
import '../../const/color_const.dart';
import '../../const/gradient.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: TEXT_BLACK),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Search',
            style: TextStyle(color: TEXT_BLACK)),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
            color: TEXT_BLACK),
            onPressed: () {
              // Code to perform search
            },
          ),
          IconButton(
            icon: Icon(Icons.settings,
            color: TEXT_BLACK),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen()));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.grey[500],
          unselectedLabelColor: TEXT_BLACK_LIGHT,
          tabs: [
            Tab(text: 'People'),
            Tab(text: 'Friends'),
            Tab(text: 'MoneyPots'),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: searchScreenGradient),
        ),

      ),
      body:
        Container(
            decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
          child: TabBarView(
            controller: _tabController,
            children: [
              PeopleSearchTab(searchController: _searchController),
              FriendsTab(searchController: _searchController),
              MoneyPotsTab(searchController: _searchController),
            ],
          ),
        ),
    );
  }
}

class PeopleSearchTab extends StatelessWidget {
  final TextEditingController searchController;

  const PeopleSearchTab({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Here you would build the UI for the 'People' tab
    return Center(child: Text('People Tab',
        style: TextStyle(color: TEXT_BLACK)));
  }
}

class FriendsTab extends StatelessWidget {
  final TextEditingController searchController;

  const FriendsTab({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Here you would build the UI for the 'Friends' tab
    return Center(child: Text('Friends Tab',
        style: TextStyle(color: TEXT_BLACK)));
  }
}

class MoneyPotsTab extends StatelessWidget {
  final TextEditingController searchController;

  const MoneyPotsTab({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Here you would build the UI for the 'MoneyPots' tab
    return Center(child: Text('MoneyPots Tab',
        style: TextStyle(color: TEXT_BLACK)));
  }
}