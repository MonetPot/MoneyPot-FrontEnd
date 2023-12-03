// import 'package:flutter/material.dart';
// import 'package:money_pot/const/color_const.dart';
// import 'package:money_pot/screens/friends/contacts.dart';
// import '../../const/gradient.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
//
// class AddGroup extends StatefulWidget {
//   const AddGroup({Key? key}) : super(key: key);
//
//   @override
//   _AddGroupState createState() => _AddGroupState();
// }
//
// class _AddGroupState extends State<AddGroup> with SingleTickerProviderStateMixin {
//   final List<bool> _selectedMembers = List.generate(10, (index) => false);
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   void _toggleSelection(int index) {
//     setState(() {
//       _selectedMembers[index] = !_selectedMembers[index];
//     });
//   }
//
//   void _createGroup() async {
//     // Assuming you have a list of selected member IDs
//     final selectedMemberIds = _selectedMembers
//         .asMap()
//         .entries
//         .where((entry) => entry.value)
//         .map((entry) => entry.key)
//         .toList();
//
//     // Construct the group data
//     var groupData = {
//       'name': 'Your Group Name', // Replace with actual group name
//       'funds': 0.0, // Replace with actual funds if needed
//       'members': selectedMemberIds,
//     };
//
//     var response = await http.post(
//       Uri.parse('http://127.0.0.1:8000/api/groups/create'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: json.encode(groupData),
//     );
//
//     if (response.statusCode == 200) {
//       print('Group created successfully');
//       // Handle successful response
//     } else {
//       print('Failed to create group');
//       // Handle error
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.close,
//           color: TEXT_BLACK),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text('MoneyPot Name', style: TextStyle(fontWeight: FontWeight.bold,
//         color: TEXT_BLACK)),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: Colors.grey[500],
//           unselectedLabelColor: TEXT_BLACK_LIGHT,
//           tabs: [
//             Tab(text: 'Contacts'),
//             Tab(text: 'Friends'),
//           ],
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(gradient: searchScreenGradient),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         icon: Icon(Icons.add_circle_rounded),
//         label: Text('Create Group'),
//         onPressed: _createGroup,
//       ),
//
//       body:
//         Container (
//             decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
//           child: Column(
//             children: [
//               Expanded(
//                 child:
//                 // Inside the AddGroup StatefulWidget's build method
//                 TabBarView(
//                   controller: _tabController,
//                   children: [
//                     Contacts(),
//                     // PeopleSearchTab(
//                     //   selectedMembers: _selectedMembers,
//                     //   toggleSelection: _toggleSelection,
//                     // ),
//                     FriendsTab(
//                       // selectedMembers: _selectedMembers,
//                       toggleSelection: _toggleSelection,
//                     ),
//                   ],
//                 ),
//
//               ),
//             ],
//           ),
//         ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:money_pot/const/color_const.dart';
import 'package:money_pot/const/gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final _groupNameController = TextEditingController();
  final List<bool> _selectedMembers = List.generate(10, (index) => false);


  void _createGroup() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;  // Get the current user's Firebase UID

    if (userId == null) {
      print('User not logged in');
      return; // Exit if user is not logged in
    }
    // Get selected member IDs (if any)
    final selectedMemberIds = _selectedMembers
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.toString())
        .toList();
    selectedMemberIds.add(userId);

    var groupData = {
      'name': _groupNameController.text, // Group name from input
      'funds': 0.0, // Default funds
      'members': selectedMemberIds, // List of selected members
    };

    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/groups/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(groupData),
    );

    if (response.statusCode == 200) {
      print('Group created successfully');
      // Handle successful response
      Navigator.pop(context);
    } else {
      print('Failed to create group');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: TEXT_BLACK),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create New Group', style: TextStyle(fontWeight: FontWeight.bold, color: TEXT_BLACK)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: searchScreenGradient),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_circle_rounded),
        label: Text('Create Group'),
        onPressed: _createGroup,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
            ),
            // Additional UI elements (e.g., member selection) can be added here
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }
}






class Member {
  final String name;
  final String email;  // or any other identifier you have

  Member({required this.name, required this.email});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      email: json['email'],
    );
  }
}


class FriendsTab extends StatefulWidget {
  final Function(int) toggleSelection;

  const FriendsTab({
    Key? key,
    required this.toggleSelection,
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
      // Handle error or show a message
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

