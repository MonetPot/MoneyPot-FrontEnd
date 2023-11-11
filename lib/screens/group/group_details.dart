import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_pot/const/color_const.dart';

import '../../Screens/settings/settings_screen.dart';
import '../../const/gradient.dart';
import '../groups_screen.dart';
import '../search/search_screen.dart';
import 'bills/text_scanner.dart';


class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({Key? key}) : super(key: key);

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme
              .of(context)
              .primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Group Name',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Theme
                .of(context)
                .primaryColor,
          ),
        ),
        flexibleSpace: Container(
          decoration: groupScreenDecoration,
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
        backgroundColor: Colors.transparent, // Make the AppBar background transparent
        elevation: 0,
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.view_list,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera_enhance_rounded),
            label: 'Scan Bill',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TextScanner()));
              // Handle Option 1
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.front_hand_rounded),
            label: 'Enter Bill Manually',
            onTap: () {
              // Handle Option 2
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.credit_card),
            label: 'Use Card',
            onTap: () {
              // Handle Option 2
            },
          ),
        ],
      ),
      body: Container(
        decoration: groupScreenDecoration, // Your group screen decoration
        child: Column(
          children: [
            SizedBox(height: 25),
            _buildTopSection(),
            SizedBox(height: 100),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Members'),
                Tab(text: 'Transactions'),
              ],
              // indicator: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10), // Creates border radius for indicator
              //   color: Theme.of(context).primaryColorDark, // Background color of the indicator
              // ),
              labelColor: Theme.of(context).primaryColor, // Color of the text when selected
              unselectedLabelColor: Colors.blueGrey, // Color of the text when unselected
              labelStyle: TextStyle(
                fontSize: 16, // Size of the text
                fontWeight: FontWeight.bold, // Weight of the text
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 15, // Size of the text when unselected
                fontWeight: FontWeight.normal, // Weight of the text when unselected
              ),
              indicatorSize: TabBarIndicatorSize.tab, // The indicator size should cover the entire tab
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0), // Padding for the indicator
              indicatorWeight: 4, // The thickness of the indicator
            ),

            Flexible(
              flex: 1,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMembersSection(),
                  _buildTransactionsSection(),
                ],
              ),
            ),
            // _buildDepositButton(),
          ],
        ),
      ),
      // ... existing floatingActionButton code ...
    );
  }

  Widget _buildMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Padding(
    padding: const EdgeInsets.all(16.0),
      child:         Text(
        'Members',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Adjust the color to match your theme
        ),
      ),
    ),
        ListView.builder(

          shrinkWrap: true, // Use this to fit within the Column
          itemCount: 3, // Replace with your dynamic item count
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                // Replace with member's image
                backgroundImage: AssetImage("assets/images/edsheeran.png"),
              ),
              title: Text(
                'Member ${index + 1}', // Replace with member's name
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Transactions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue, // Adjust the color to match your theme
            ),
          ),
        ),
        ListView.builder(
          // physics: NeverScrollableScrollPhysics(), // to disable ListView's scrolling
          shrinkWrap: true, // Use this to fit within the Column
          itemCount: 3, // Replace with your dynamic item count
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                // Replace with member's image
                backgroundImage: AssetImage("assets/images/edsheeran.png"),
              ),
              title: Text(
                'Member ${index + 1}', // Replace with member's name
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'June 15, 2023', // Replace with the transaction date
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.blue : Colors.red, // Change color based on condition
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  index.isEven ? '\$50 Withdrawal' : '\$300 Deposit', // Replace with transaction amount
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }


  Widget _buildTopSection() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/edsheeran.png'), // Replace with your image path
        ),
        Text('Group for Friday night drinks'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // This will space out the buttons evenly
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0), // Add some space between the buttons
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Button background color
                      onPrimary: Colors.white, // Button text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0), // Button padding
                    ),
                    onPressed: () {
                      // Handle Deposit button press
                    },
                    child: Text(
                      'Deposit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0), // Add some space between the buttons
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple, // Button background color
                      onPrimary: Colors.white, // Button text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0), // Button padding
                    ),
                    onPressed: () {
                      // Handle Add Members button press
                    },
                    child: Text(
                      'Add Members',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

      ],
    );
  }

  Widget _buildFundsOverview() {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Money Pot'),
          Text('\$700'),
          // Include other details like Total Members and Transactions
        ],
      ),
    );
  }

// ... Rest of your widget code ...
}

