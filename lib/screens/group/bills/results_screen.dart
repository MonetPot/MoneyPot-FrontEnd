import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


class ResultScreen extends StatefulWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  double subTotal = 0.0;
  double taxValue = 0.0;
  double totalValue = 0.0;
  double selectedTipPercentage = 0.0;
  double customTip = 0.0;

  @override
  void initState() {
    super.initState();
    _parseText(widget.text);
  }


  double calculateTip(double percentage) {
    return totalValue * (percentage / 100);
  }

  double getTotalWithTip() {
    double tipAmount = (selectedTipPercentage > 0) ? calculateTip(selectedTipPercentage) : customTip;
    return totalValue + tipAmount;
  }

  Future<ReceiptInfo> _parseText(String scannedText) async {
    // Process the scanned text and return ReceiptInfo
    List<String> lines = scannedText.split('\n');
    return ConfirmHelper.getItems(lines);
  }

  double _extractNumberFromLine(String line) {
    // Attempt to find the numerical value in the line
    var matches = RegExp(r'\b(\d+(\.\d{1,2})?)\b').allMatches(line);
    if (matches.isNotEmpty) {
      // Assuming the last match is the amount
      var match = matches.last;
      // print(match);
      return double.tryParse(match.group(0)!) ?? 0.0;
    }
    return 0.0;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Bill Summary'),
      ),
      body: FutureBuilder<ReceiptInfo>(
        future: _receiptFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            // Data is available here as snapshot.data
            ReceiptInfo receiptInfo = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display items, subtotal, tax, and total with tip
                  // ...
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
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


class BillSummary {
  final double subtotal;
  final double tax;

  BillSummary({required this.subtotal, required this.tax});

  double get total => subtotal + tax;
}

class ConfirmHelper {

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
    List items = new List();
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
        String scannedQuantity = quantityExp.stringMatch(lines[i]);
        // console.log(lines[i], ' ' , quantity)
        if(scannedQuantity != null){
          RegExp subQuantityExp = new RegExp(r"([0-9]){1,3}");
          String parseQuantity = subQuantityExp.stringMatch(scannedQuantity); //in case quantity has bracket ex. (3)
          quantity = int.parse(parseQuantity);
          if(quantity > 1){
            lineCost /= quantity;
          }
        }else{
          quantity = 1;
        }

        if(calcTotal + lineCost <= scanTotal){
          calcTotal += lineCost;
          lines[i] = lines[i].replaceAll(rawCost, ''); // remove cost from line
          lines[i] = lines[i].trim();
          items.add(new Item(lines[i], lineCost, lineCost/quantity, quantity));
        }



      }
    }

    //finding which final values to use
    finalTotal = scanTotal;
    finalTax = scanTax;
    // if(scanTotal == (subtotal + scanTax)){
    //         finalTax = scanTax;
    //         finalTotal = scanTotal;
    //     }else if(calcTotal == (subtotal + scanTax)){
    //         finalTax = scanTax;
    //         finalTotal = calcTotal;
    //     }else if(calcTotal == (subtotal + calcTax)){
    //         finalTax = calcTax;
    //         finalTotal = calcTotal;
    //     }else{
    //         finalTax = calcTax;
    //         finalTotal = scanTotal;
    //     }
    return (new ReceiptInfo(items, finalTotal, finalTax));
  }




  static List<num> getLineMesh(List p, avgHeight, bool isTopLine){
    if(isTopLine){//expand the boundingBox
      p[1][1] += avgHeight;
      p[0][1] += avgHeight;
    }else{
      p[1][1] -= avgHeight;
      p[0][1] -= avgHeight;
    }
    num xDiff = (p[1][0] - p[0][0]);
    num yDiff = (p[1][1] - p[0][1]);

    num gradient = yDiff / xDiff;//if gradient is 0, the line is flat
    // print('GRADIENT:');
    // print(xDiff);
    // print(yDiff);
    // print(gradient);
    num xThreshMin = 1; //min width of the image
    num xThreshMax = 3000;

    num yMin = 0;
    num yMax = 0;

    if(gradient == 0){//if line is flat
      //line will be flat
      // print('FLAT');
      yMin = p[0][1];
      yMax = p[0][1];
    }else{//there will be variance in y
      yMin = p[0][1] - (gradient*(p[0][0] - xThreshMin));
      yMax = p[0][1] + (gradient*(p[0][0] + xThreshMax));
    }
    // print([xThreshMin, xThreshMax, yMin, yMax]);
    return [xThreshMin, xThreshMax, yMin, yMax];

  }
}

class ReceiptInfo {
  List items;
  num finalTotal;
  num finalTax;

  ReceiptInfo(List items, num finalTotal, num finalTax){
    this.items = items;
    this.finalTotal = finalTotal;
    this.finalTax = finalTax;
  }
}




