import 'package:flutter/material.dart';

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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Code to perform search
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Code to open settings
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'People'),
            Tab(text: 'Friends'),
            Tab(text: 'MoneyPots'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PeopleSearchTab(searchController: _searchController),
          FriendsTab(searchController: _searchController),
          MoneyPotsTab(searchController: _searchController),
        ],
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
    return Center(child: Text('People Tab'));
  }
}

class FriendsTab extends StatelessWidget {
  final TextEditingController searchController;

  const FriendsTab({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Here you would build the UI for the 'Friends' tab
    return Center(child: Text('Friends Tab'));
  }
}

class MoneyPotsTab extends StatelessWidget {
  final TextEditingController searchController;

  const MoneyPotsTab({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Here you would build the UI for the 'MoneyPots' tab
    return Center(child: Text('MoneyPots Tab'));
  }
}