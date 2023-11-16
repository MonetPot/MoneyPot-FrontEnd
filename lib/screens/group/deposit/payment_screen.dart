import 'package:flutter/material.dart';

import '../../../Screens/settings/settings_screen.dart';
import '../../../const/gradient.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Payments', style: TextStyle(color: Colors.black)),
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
                _buildBalanceContainer(),
                SizedBox(height: 24),
                _buildChipSection(),
                SizedBox(height: 24),
                _buildAmountTextField(),
                SizedBox(height: 24),
                _buildNextButton(context),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildBalanceContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        'MoneyPot\n\$1,000',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildChipSection() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/edsheeran.png"), // Replace with your image path
        ),
        SizedBox(width: 8),
        Chip(label: Text('Friday Night')),
        SizedBox(width: 8),
        Chip(
          label: Text('Deposit'),
          backgroundColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildAmountTextField() {
    return TextField(
      controller: _amountController,
      focusNode: _amountFocusNode,
      decoration: InputDecoration(
        labelText: 'Amount',
        suffixText: 'USD',
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmDepositScreen()));
      },
      child: Text('Next'),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }
}
