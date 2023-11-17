import 'package:flutter/material.dart';
import 'package:money_pot/const/color_const.dart';
import 'package:money_pot/const/gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../group_details.dart';

class TransactionSummaryScreen extends StatelessWidget {
  final String amount;
  late final String userName;
  late final String userEmail;
  final User? user = FirebaseAuth.instance.currentUser;
  TransactionSummaryScreen({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userName = user?.displayName ?? 'No Name';
    userEmail = user?.email ?? 'No Email';
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
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: groupScreenGradient),
        ),
      ),
      body:
        Container(
          decoration: BoxDecoration(gradient: groupDetailsGradient),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTransactionCard(),
                SizedBox(height:10),
                doneButtonWidget("Done", context),
              ],
            ),
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
            _buildDetailRow('Member', userName),
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

  Widget doneButtonWidget(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(36.0),
        gradient: LinearGradient(
          begin: FractionalOffset.centerLeft,
          stops: [0.2, 1],
          colors: [
            Color(0xff000000),
            Color(0xff434343),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(0.0, 32.0),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // String amount = _amountController.text;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  GroupDetailsScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
          ),
          onPrimary: Color(0xffF1EA94),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
