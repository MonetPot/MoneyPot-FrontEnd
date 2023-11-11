import 'package:flutter/material.dart';


class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> with SingleTickerProviderStateMixin {
  final List<bool> _selectedMembers = List.generate(10, (index) => false);
  late TabController _tabController;

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

  void _createGroup() {
    final selectedIndices =
    _selectedMembers.asMap().entries.where((entry) => entry.value).map((entry) => entry.key).toList();
    print('Selected members indices: $selectedIndices');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('MoneyPot Name', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'People'),
            Tab(text: 'Friends'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_circle_rounded),
        label: Text('Create Group'),
        onPressed: () {
          // Your onPressed code here
        },
      ),
      body: Column(
        children: [
          Expanded(
            child:
            // Inside the AddGroup StatefulWidget's build method
            TabBarView(
              controller: _tabController,
              children: [
                PeopleSearchTab(
                  selectedMembers: _selectedMembers,
                  toggleSelection: _toggleSelection,
                ),
                FriendsTab(
                  selectedMembers: _selectedMembers,
                  toggleSelection: _toggleSelection,
                ),
              ],
            ),

          ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: _createGroup,
          //     child: Text('Create Group'),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class PeopleSearchTab extends StatelessWidget {
  final List<bool> selectedMembers;
  final Function(int) toggleSelection;

  const PeopleSearchTab({
    Key? key,
    required this.selectedMembers,
    required this.toggleSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Here you would build the UI for the 'People' tab
    return _SelectableMemberList(
      selectedMembers: selectedMembers,
      toggleSelection: toggleSelection,
    );
  }
}


class FriendsTab extends StatelessWidget {
  final List<bool> selectedMembers;
  final Function(int) toggleSelection;

  const FriendsTab({
    Key? key,
    required this.selectedMembers,
    required this.toggleSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Here you would build the UI for the 'Friends' tab
    return _SelectableMemberList(
      selectedMembers: selectedMembers,
      toggleSelection: toggleSelection,
    );
  }
}

class _SelectableMemberList extends StatelessWidget {
  final List<bool> selectedMembers;
  final Function(int) toggleSelection;

  const _SelectableMemberList({
    Key? key,
    required this.selectedMembers,
    required this.toggleSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      // No need for thumbVisibility or isAlwaysShown, as Scrollbar will show automatically when there's a scroll event
      child: ListView.builder(
        itemCount: selectedMembers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Person ${index + 1}'),
            subtitle: Text('@username-${index + 1}'),
            trailing: Icon(
              selectedMembers[index] ? Icons.circle : Icons.circle_outlined,
              color: selectedMembers[index] ? Colors.blue : null,
            ),
            onTap: () => toggleSelection(index),
          );
        },
      ),
    );
  }
}



// class AddGroup extends StatefulWidget {
//   const AddGroup({Key? key}) : super(key: key);
//
//   @override
//   _AddGroupState createState() => _AddGroupState();
// }
//
// class _AddGroupState extends State<AddGroup> with SingleTickerProviderStateMixin{
//   final List<bool> _selectedMembers = List.generate(10, (index) => false);
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
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
//   void _createGroup() {
//     // Here you would handle group creation using the list of selected members
//     // For example, you could extract the indices or details of the members that are selected:
//     final selectedIndices =
//     _selectedMembers.asMap().entries.where((entry) => entry.value).map((entry) => entry.key).toList();
//
//     // TODO: Use selectedIndices for whatever you need for group creation
//     print('Selected members indices: $selectedIndices');
//
//     // After creating the group, you might want to navigate away or show a success message
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.close),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text('MoneyPot Name', style: TextStyle(fontWeight: FontWeight.bold)),
//         actions: <Widget>[],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'People'),
//             Tab(text: 'Friends'),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           TabBarView(
//             controller: _tabController,
//             children: [
//               PeopleSearchTab(),
//               FriendsTab(),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _selectedMembers.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text('Person ${index + 1}'),
//                   subtitle: Text('@username-${index + 1}'),
//                   trailing: Icon(
//                     _selectedMembers[index] ? Icons.circle : Icons.circle_outlined,
//                     color: Colors.black
//                   ),
//                   onTap: () => _toggleSelection(index),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: _createGroup,
//               child: Text('Create Group'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PeopleSearchTab extends StatelessWidget {
//
//   const PeopleSearchTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Here you would build the UI for the 'People' tab
//     return Center(child: Text('People Tab'));
//   }
// }
//
// class FriendsTab extends StatelessWidget {
//
//   const FriendsTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Here you would build the UI for the 'Friends' tab
//     return Center(child: Text('Friends Tab'));
//   }
// }



// class AddGroup extends StatelessWidget {
//   const AddGroup({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.close),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text('MoneyPot Name', style: TextStyle(fontWeight: FontWeight.bold)),
//         actions: <Widget>[
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             // Using Expanded here to allow the ListView to take up all available space
//             child: ListView.builder(
//               itemCount: 10, // Replace with your dynamic content count
//               itemBuilder: (BuildContext context, int index) {
//                 // Replace with your custom ListTile or another widget for content
//                 return ListTile(
//                   title: Text('Person ${index + 1}'),
//                   subtitle: Text('@username-${index + 1}'),
//                   trailing: Icon(Icons.check_circle_outline),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Handle group creation
//               },
//               child: Text('Create Group'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

