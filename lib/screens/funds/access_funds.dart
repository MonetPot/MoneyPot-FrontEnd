import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Screens/settings/settings_screen.dart';
import '../../const/gradient.dart';
import '../../const/styles.dart';

class AccessFunds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme
              .of(context)
              .primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),// Back icon
        title: Text(
          'Payments',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: SIGNUP_CARD_BACKGROUND),
        ),
        // backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.blue), // Settings/Options icon
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'MoneyPot\n\$520',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  // User avatar
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
                ),
                SizedBox(width: 10),
                Chip(
                  label: Text('Friday Night'),
                ),
                SizedBox(width: 10),
                Chip(
                  label: Text('Withdrawal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
            //   controller: controller,
              style: hintAndValueStyle,
              // focusNode: focusNode,
              // obscureText: obscureText,
              keyboardType: TextInputType.number,
              // readOnly: onTap != null,
              // onTap: onTap,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.attach_money_rounded),
                contentPadding: EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                labelText: 'Enter Amount',
                hintStyle: hintAndValueStyle,
              ),
              // onSubmitted: onFieldSubmitted,
            ),
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Amount',
            //     border: OutlineInputBorder(),
            //   ),
            //   keyboardType: TextInputType.number,
            // ),
            // SizedBox(height: 10),
            Row(
              children: [
                WithdrawButtonWidget(),
                // Expanded(
                //   child:
                //     WithdrawButtonWidget(),
                //   // ElevatedButton(
                //   //   onPressed: () {
                //   //     // Handle withdraw press
                //   //   },
                //   //   child: Text('Withdraw'),
                //   //   style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                //   // ),
                // ),
                SizedBox(width: 10),
                TransferButtonWidget(),
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Handle transfer press
                //     },
                //     child: Text('Transfer'),
                //     style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget TransferButtonWidget() {
  return Container(
    margin: EdgeInsets.only(left: 32.0, top: 32.0),
    child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 13.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: Offset(0.0, 32.0)),
                ],
                borderRadius: new BorderRadius.circular(36.0),
                gradient: LinearGradient(begin: FractionalOffset.centerLeft,
                    stops: [
                      0.2,
                      1
                    ], colors: [
                      Color(0xff000000),
                      Color(0xff434343),
                    ])),
            child: Text(
              'Transfer',
              style: TextStyle(
                  color: Color(0xffF1EA94),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget WithdrawButtonWidget() {
  return Container(
    margin: EdgeInsets.only(left: 20.0, top: 32.0),
    child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 13.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: Offset(0.0, 32.0)),
                ],
                borderRadius: new BorderRadius.circular(36.0),
                gradient: LinearGradient(begin: FractionalOffset.centerLeft,
                    stops: [
                      0.2,
                      1
                    ], colors: [
                      Color(0xff000000),
                      Color(0xff434343),
                    ])),
            child: Text(
              'Withdraw',
              style: TextStyle(
                  color: Color(0xffF1EA94),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ],
    ),
  );
}
