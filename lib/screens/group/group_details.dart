import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_pot/screens/group/deposit/payment_screen.dart';

import '../../Screens/settings/settings_screen.dart';
import '../../const/gradient.dart';
import 'package:money_pot/screens/group/groups_screen.dart';
import '../search/search_screen.dart';
import 'bills/text_scanner.dart';
import 'package:money_pot/screens/group/add_group.dart';


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
          decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                  SlideFromLeftPageRoute(page: SearchScreen()));
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
        // Make the AppBar background transparent
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
        decoration: BoxDecoration(gradient: groupDetailsGradient), // Your group screen decoration
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
              labelColor: Theme
                  .of(context)
                  .primaryColor,
              unselectedLabelColor: Colors.blueGrey,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight
                    .normal,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0),
              indicatorWeight: 4,
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
          color: Colors.blue,
        ),
      ),
    ),
        ListView.builder(

          shrinkWrap: true,
          itemCount: 3, // Replace with dynamic item count
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(

                backgroundImage: AssetImage("assets/images/edsheeran.png"),
              ),
              title: Text(
                'Member ${index + 1}', // Replace with group members
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
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3, // Replace with dynamic item count
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/edsheeran.png"),
              ),
              title: Text(
                'Member ${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'June 15, 2023',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  index.isEven ? '\$50 Withdrawal' : '\$300 Deposit',
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
          backgroundImage: AssetImage('assets/images/edsheeran.png'),
        ),
        Text('Group for Friday night drinks'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen()));
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
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    onPressed: () {
                      _openAddGroupScreen(context);
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

