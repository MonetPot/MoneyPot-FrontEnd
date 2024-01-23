import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:collection';
import 'dart:io';

class ResultScreen extends StatefulWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  num subTotal = 0.0;
  num taxValue = 0.0;
  num totalValue = 0.0;
  double selectedTipPercentage = 0.0;
  double customTip = 0.0;
  ReceiptInfo? receiptInfo;
  bool receiptReady = false;

  @override
  void initState() {
    super.initState();
    _parseText(widget.text);
  }

  Future<void> _parseText(String scannedText) async {
    // Process the scanned text and return ReceiptInfo
    List<String> lines = scannedText.split('\n');
    ReceiptInfo info = getItems(lines);

    setState(() {
      receiptInfo = info;
      receiptReady = true;
      // Update subtotal, tax, and total value
      subTotal = info.subtotal;
      taxValue = info.tax;
      totalValue = info.finalTotal;
    });
  }

  double calculateTip(double percentage) {
    return totalValue * (percentage / 100);
  }

  double getTotalWithTip() {
    double tipAmount = (selectedTipPercentage > 0) ? calculateTip(selectedTipPercentage) : customTip;
    return totalValue + tipAmount;
  }

  void navigateToTotalWithTipScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TotalWithTipScreen(totalWithTip: getTotalWithTip()),
      ),
    );
  }

  Widget _tipOptionButton(String tipLabel, double tipPercentage) {
    return Flexible(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedTipPercentage = tipPercentage;
            customTip = 0.0; // Reset custom tip
            navigateToTotalWithTipScreen();
          });
        },
        child: Text(tipLabel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!receiptReady) {
      return Scaffold(
        appBar: AppBar(title: Text('Processing Receipt')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Scanned Bill Summary')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: receiptInfo!.items.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  title: Text(receiptInfo!.items[i].name),
                  trailing: Text('\$${receiptInfo!.items[i].totalCost.toStringAsFixed(2)}'),
                );
              },
            ),
            Divider(color: Colors.grey),
            Text(
              'Subtotal: \$${subTotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Tax: \$${taxValue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tipOptionButton('15%', 15),
                _tipOptionButton('18%', 18),
                _tipOptionButton('20%', 20),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Custom Tip', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                setState(() {
                  customTip = double.tryParse(value) ?? 0.0;
                  selectedTipPercentage = 0.0; // Reset the selected tip percentage
                  navigateToTotalWithTipScreen();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  static num findSubtotal(List lines){

    RegExp subtotalExp = new RegExp(r"[Ss][Uu][Bb]\s?[Tt][Oo][Tt][Aa][Ll]");
    RegExp moneyExp = new RegExp(r"([0-9]{1,3}\.[0-9]{2})");


    for(int i = lines.length-1; i >= 0; i--){
      if(subtotalExp.hasMatch(lines[i]) && moneyExp.hasMatch(lines[i])){
        num lineCost = num.parse(moneyExp.stringMatch(lines[i]).toString());
        return lineCost;
      }
    }
    return -1;
  }

  static getItems(List lines){
    //variables to fill
    num scanTotal = 0;
    num subtotal = 0;
    num calcTax = 0;
    num scanTax = 0;
    List<Item> items = [];
    num calcTotal = 0;
    //final variables
    num finalTotal = 0;
    num finalTax = 0;

    //REGEX
    RegExp moneyExp = new RegExp(r"([0-9]{1,3}\.[0-9]{2})");
    RegExp totalExp = new RegExp(r"([Tt][Oo][Tt][Aa][Ll])");
    RegExp taxExp = new RegExp(r"([Tt][Aa][Xx])|([Hh][Ss][Tt])|([Gg][Ss][Tt])");
    RegExp quantityExp = new RegExp(r"^([0-9]){1,3}\s|[(]([0-9]){1,3}");

    // RegExp totalExp = new RegExp(r"([Tt][Oo][Tt][Aa][Ll])");


    //1. GET TOTAL (largest number)
    num totalLine = 0;

    for(int i = 0; i < lines.length; i++){
      if(moneyExp.hasMatch(lines[i])){
        num lineCost = num.parse(moneyExp.stringMatch(lines[i]).toString());
        // console.log(lineCost)
        if(lineCost > scanTotal){
          totalLine = i;
          scanTotal = lineCost;
        }
      }
    }
    print('SCAN TOTAL: ' + scanTotal.toString());
    while(lines.length > totalLine+1){
      lines.removeLast();
    }

    //2. GET SUBTOTAL
    subtotal = findSubtotal(lines);

    //remove lines with the word total in them (both total and subtotal)
    for(int i = lines.length-1; i >= 0; i--){
      if(totalExp.hasMatch(lines[i])){
        lines.removeAt(i);
      }
    }
    //3. FIND TAX/TIP if subtotal is less than the total
    //  FIND TAX from scanning the text and
    if(subtotal != -1 && subtotal < scanTotal){
      calcTax = scanTotal-subtotal;
    }
    //  FIND TAX from scanning the text and remove lines with tax in them
    for(int i = lines.length-1; i >= 0; i--){
      if(taxExp.hasMatch(lines[i]) && moneyExp.hasMatch(lines[i])){
        num lineCost = num.parse(moneyExp.stringMatch(lines[i]).toString());
        scanTax += lineCost;
        lines.removeAt(i);
      }
    }

    //4.FIND ITEMS AND QUANTITY
    for(int i = 0; i < lines.length; i++){
      int quantity = 0;
      if(moneyExp.hasMatch(lines[i]) && num.parse(moneyExp.stringMatch(lines[i]).toString()) < scanTotal){
        var rawCost = moneyExp.stringMatch(lines[i]).toString();
        var lineCost = num.parse(rawCost);
        String? scannedQuantity = quantityExp.stringMatch(lines[i]);
        // console.log(lines[i], ' ' , quantity)
        if(scannedQuantity != null){
          RegExp subQuantityExp = new RegExp(r"([0-9]){1,3}");
          String? parseQuantity = subQuantityExp.stringMatch(scannedQuantity); //in case quantity has bracket ex. (3)
          quantity = int.parse(parseQuantity!);
          if(quantity > 1){
            lineCost /= quantity;
          }
        }else{
          quantity = 1;
        }

        if(calcTotal + lineCost <= scanTotal){
          calcTotal += lineCost;
          lines[i] = lines[i].replaceAll(rawCost, '');
          lines[i] = lines[i].trim();
          items.add(Item(
              name: lines[i],
              totalCost: lineCost,
              unitCost: lineCost / quantity,
              quantity: quantity
          ));

        }



      }
    }

    //finding which final values to use
    finalTotal = scanTotal;
    finalTax = scanTax;
    return ReceiptInfo(
        items: items,
        subtotal: subtotal,
        finalTotal: finalTotal,
        tax: finalTax
    );
  }


}

class ReceiptInfo {
  final List<Item> items;
  final num subtotal;
  final num tax;
  final num finalTotal;

  ReceiptInfo({required this.items, required this.subtotal, required this.tax, required this.finalTotal});
}

class Item {
  final String name;
  final num totalCost;
  final num unitCost;
  final int quantity;

  Item({required this.name, required this.totalCost, required this.unitCost, required this.quantity});
}

class TotalWithTipScreen extends StatelessWidget {
  final double totalWithTip;

  const TotalWithTipScreen({Key? key, required this.totalWithTip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total with Tip'),
      ),
      body: Center(
        child: Text(
          'Total: \$${totalWithTip.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}







