import 'package:flutter/material.dart';
import 'package:money_pot/const/color_const.dart';
import 'package:money_pot/const/gradient.dart';
import 'package:money_pot/screens/group/deposit/summary_screen.dart';

import '../../../Screens/settings/settings_screen.dart';

class ConfirmDepositScreen extends StatelessWidget {

  final String amount;
  final int groupId;
  late String groupName = " ";
  late int funds;
  final String identifier;
  // late List<Member> members;

  ConfirmDepositScreen({Key? key, required this.amount, required this.groupId, required this.groupName, required this.identifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Confirm', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen()));
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
                Text('Deposit', style: TextStyle(fontSize: 24.0, color: TEXT_BLACK)),
                SizedBox(height: 16),
                _buildSummaryCard(),
                SizedBox(height:10),
                // Spacer(),
                transferButtonWidget("Transfer", context),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSummaryRow('Amount', '\$${amount}'),
              _buildSummaryRow('Charge', '0'),
              Divider(),
              _buildSummaryRow(groupName, '\$${amount}', isTotal: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16.0, color: isTotal ? Colors.black : Colors.grey)),
          Text(value, style: TextStyle(fontSize: 16.0, color: isTotal ? Colors.black : Colors.grey)),
        ],
      ),
    );
  }

  Widget transferButtonWidget(String text, BuildContext context) {
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
                  builder: (context) => TransactionSummaryScreen(amount: amount, groupId: groupId, groupName: groupName, identifier: identifier)));
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

  Widget _buildTransferButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionSummaryScreen(amount: amount, groupId: groupId, groupName: groupName, identifier: identifier)));
      },
      child: Text('Transfer'),
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
