import 'package:flutter/material.dart';

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
    final billSummary = parseBillSummary(widget.text);
    subTotal = billSummary.subtotal;
    taxValue = billSummary.tax;
    totalValue = subTotal + taxValue;
  }


  double calculateTip(double percentage) {
    return totalValue * (percentage / 100);
  }

  double getTotalWithTip() {
    double tipAmount = (selectedTipPercentage > 0) ? calculateTip(selectedTipPercentage) : customTip;
    return totalValue + tipAmount;
  }

  BillSummary parseBillSummary(String scannedText) {
    double subtotal = 0.0;
    double tax = 0.0;
    print(scannedText);
    List<String> lines = scannedText.split('\n');
    print(lines);
    for (String line in lines) {
      print(line);
      if (line.contains('Sub Total')) {
        print(line);
        subtotal = _extractNumberFromLine(line);
      } else if (line.contains('Tax')) {
        print(line);
        tax = _extractNumberFromLine(line);
      }
    }

    return BillSummary(subtotal: subtotal, tax: tax);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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




// List<Map<String, dynamic>> parseBillItems(String scannedText) {
//   List<Map<String, dynamic>> parsedItems = [];
//   List<String> lines = scannedText.split('\n');
//   bool foundItemsStart = false;
//
//   for (var line in lines) {
//     print('Checking line: $line'); // Debug print each line
//
//     if (line.contains('TO GO')) {
//       foundItemsStart = true;
//       continue; // Skip the "TO GO" line itself
//     }
//
//     if (line.contains('SUBTOTAL')) {
//       break; // Stop parsing at "SUBTOTAL"
//     }
//
//     if (foundItemsStart && line.trim().isNotEmpty) {
//       print('Item captured: $line'); // Debug print captured item
//       parsedItems.add({
//         'description': line.trim(),
//         'selected': false, // Default to unselected for a checkbox
//       });
//     }
//   }
//
//   print('Parsed bill items count: ${parsedItems.length}'); // Debug print total items found
//   return parsedItems;
// }




// List<String> _parseBillLines(String text) {
//   var lines = text.split('\n');
//   var parsedLines = <String>[];
//   bool startParsing = false;
//
//   // Regex to identify dashed/dotted lines
//   var dashedLineRegex = RegExp(r'^[-. ]+$');
//
//   // Debug: Print each line
//   print("Scanned Lines:");
//   lines.forEach(print);
//
//   for (var line in lines) {
//     if (!startParsing && dashedLineRegex.hasMatch(line)) {
//       startParsing = true;
//       continue;
//     }
//
//     if (startParsing) {
//       // Debug: Print the line that's being added
//       print("Adding line: $line");
//       parsedLines.add(line);
//     }
//   }
//
//   print('Total items found: ${parsedLines.length}');
//   return parsedLines;
// }
