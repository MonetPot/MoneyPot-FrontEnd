import 'package:flutter/material.dart';
import 'package:money_pot/const/color_const.dart';
import 'package:money_pot/screens/friends/contacts.dart';
import '../../const/gradient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AddMembers extends StatefulWidget {
  final int groupId;
  final String identifier;
  const AddMembers({Key? key, required this.groupId, required this.identifier}) : super(key: key);


  @override
  _AddMembersState createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> with SingleTickerProviderStateMixin {
  final List<bool> _selectedMembers = List.generate(10, (index) => false);
  late TabController _tabController;
  List<Member> friends = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleSelection(int index) {
    setState(() {
      _selectedMembers[index] = !_selectedMembers[index];
    });
  }

  void _createGroup() async {
    final selectedMemberIdentifiers = friends
        .where((member) => _selectedMembers[friends.indexOf(member)])
        .map((member) => member.email)
        .toList();

    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/groups/${widget.groupId}/join'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'members': selectedMemberIdentifiers}),
    );

    if (response.statusCode == 200) {
      print('Members added to group successfully');
    } else {
      print('Failed to add members to group');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close,
          color: TEXT_BLACK),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('MoneyPot Name', style: TextStyle(fontWeight: FontWeight.bold,
        color: TEXT_BLACK)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.grey[500],
          unselectedLabelColor: TEXT_BLACK_LIGHT,
          tabs: [
            Tab(text: 'Contacts'),
            Tab(text: 'Friends'),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: searchScreenGradient),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_circle_rounded),
        label: Text('Add members'),
        onPressed: _createGroup,
      ),

      body:
        Container (
            decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
          child: Column(
            children: [
              Expanded(
                child:
                // Inside the AddGroup StatefulWidget's build method
                TabBarView(
                  controller: _tabController,
                  children: [
                    Contacts(),
                    // PeopleSearchTab(
                    //   selectedMembers: _selectedMembers,
                    //   toggleSelection: _toggleSelection,
                    // ),
                    FriendsTab(
                      // selectedMembers: _selectedMembers,
                      toggleSelection: _toggleSelection,
                      identifier: widget.identifier,

                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
    );
  }
}


class Member {
  final String name;
  final String email;
  final String uid;

  Member({required this.name, required this.email, required this.uid});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      email: json['email'],
      uid: json['firebase_id'],
    );
  }
}


class FriendsTab extends StatefulWidget {
  final Function(int) toggleSelection;
  final String identifier;

  const FriendsTab({
    Key? key,
    required this.toggleSelection,
    required this.identifier,
  }) : super(key: key);

  @override
  _FriendsTabState createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  List<Member>? _friends;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFriends();
  }

  Future<void> _fetchFriends() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/users/{identifier}/friends'));
    if (response.statusCode == 200) {
      List<Member> friends = (json.decode(response.body) as List)
          .map((data) => Member.fromJson(data))
          .toList();
      setState(() {
        _friends = friends;
        _isLoading = false;
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _SelectableMemberList(
      members: _friends!,
      toggleSelection: widget.toggleSelection,
    );
  }
}

class _SelectableMemberList extends StatelessWidget {
  final List<Member> members;
  final Function(int) toggleSelection;

  const _SelectableMemberList({
    Key? key,
    required this.members,
    required this.toggleSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(members[index].name),
          onTap: () => toggleSelection(index),

        );
      },
    );
  }
}