import 'package:flutter/material.dart';

import '../../../Screens/settings/settings_screen.dart';
import '../../../const/gradient.dart';
import 'confirmation_screen.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {

  final int groupId;
  late String groupName;

  final String identifier;

  // late List<Member> members;

  PaymentScreen(
      {Key? key, required this.groupId, required this.groupName, required this.identifier})
      : super(key: key);


  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}


class _PaymentScreenState extends State<PaymentScreen> {

  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  int funds = 0;


  @override
  void initState() {
    super.initState();
    fetchGroupFunds();
  }

  void fetchGroupFunds() async {
    var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/groups/${widget.groupId}/funds'));
    if (response.statusCode == 200) {
      setState(() {
        funds = int.parse(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Funds', style: TextStyle(color: Colors.black)),
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
                // SizedBox(height: 24),
                // _buildNextButton(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: depositButtonWidget("Deposit", context)),
                    // SizedBox(width: 16), // Adds a gap between the buttons
                    Expanded(child: withdrawButtonWidget("Withdraw", context)),
                  ],
                ),
              ],
            ),
          ),
        ),
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
        'MoneyPot\n\$$funds',
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
          backgroundImage: AssetImage("assets/images/edsheeran.png"),
        ),
        SizedBox(width: 8),
        Chip(label: Text(widget.groupName),
          backgroundColor: Colors.green,),
        SizedBox(width: 8),
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

  Widget depositButtonWidget(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
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
          String amount = _amountController.text;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmDepositScreen(amount: amount, groupId: widget.groupId, groupName: widget.groupName, identifier: widget.identifier)));
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

  Widget withdrawButtonWidget(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
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
          String amount = _amountController.text;
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ConfirmDepositScreen(amount: amount)));
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


  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String amount = _amountController.text;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmDepositScreen(amount: amount, groupId: widget.groupId, groupName: widget.groupName, identifier: widget.identifier)));
      },
      child: Text('Next'),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }
}
