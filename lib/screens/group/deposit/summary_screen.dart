import 'package:flutter/material.dart';

import '../group_details.dart';

class TransactionSummaryScreen extends StatelessWidget {
  final String amount;

  TransactionSummaryScreen({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Transaction', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.blue),
            onPressed: () {
              // Settings action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTransactionCard(),
            Spacer(),
            _buildDoneButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard() {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow('Amount', '\$${amount}'),
            _buildDetailRow('Date', '06/14/2023'),
            _buildDetailRow('MoneyPot', 'Friday Night'),
            _buildDetailRow('Type', 'Deposit'),
            _buildDetailRow('Member', 'Jason Britto'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16.0, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GroupDetailsScreen(),
          ),
        );
      },
      child: Text('Done'),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
