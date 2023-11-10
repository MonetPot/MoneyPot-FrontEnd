import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Friday Night'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildTopSection(),
          ),
          SliverToBoxAdapter(
            child: _buildFundsOverview(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildMembersSection(),
                _buildTransactionsSection(),
              ],
            ),
          ),
        ],
      ),
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
        // Add more widgets or styling as necessary
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

  Widget _buildMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Members', style: TextStyle(fontSize: 18)),
        // You can use a ListView.builder or a Column with hardcoded members
        // Here's an example with hardcoded members:
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/edsheeran.png'), // Replace with member image path
          ),
          title: Text('Member 1'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/edsheeran.png'), // Replace with member image path
          ),
          title: Text('Member 2'),
        ),
        // Add more members as necessary
      ],
    );
  }
  Widget _buildTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transactions', style: TextStyle(fontSize: 18)),
        // Similarly, you can use a ListView.builder or a Column for transactions
        ListTile(
          title: Text('Member 3'),
          subtitle: Text('June 14, 2023'),
          trailing: Text('\$83.78 Withdrawal'),
        ),
        ListTile(
          title: Text('Member 3'),
          subtitle: Text('June 14, 2023'),
          trailing: Text('\$35 Withdrawal'),
        ),
        // Add more transactions as necessary
      ],
    );
  }

  Widget _buildActionButton(String title, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Button color
        onPrimary: Colors.white, // Text color
      ),
      child: Text(title),
    );
  }



}
