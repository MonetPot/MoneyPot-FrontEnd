// import 'package:flutter/material.dart';
//
// class ResultScreen extends StatefulWidget {
//   final String text;
//
//   const ResultScreen({Key? key, required this.text}) : super(key: key);
//
//   @override
//   _ResultScreenState createState() => _ResultScreenState();
// }
//
// class _ResultScreenState extends State<ResultScreen> {
//   late List<BillItem> billItems;
//
//   @override
//   void initState() {
//     super.initState();
//     billItems = parseBillItems(widget.text);
//   }
//
//   List<BillItem> parseBillItems(String text) {
//
//     // final itemPriceRegex1 = RegExp(r'^(.+?)\s+(\d+\.\d{2})$');
//     // final match = itemPriceRegex.firstMatch('1 C BNLS 6 WINGS       11.49');
//     // if (match != null) {
//     //   final itemName1 = match.group(1)?.trim(); // '1 C BNLS 6 WINGS'
//     //   final itemPrice1 = match.group(2)?.trim(); // '11.49'
//     // }
//     // Split the text by new lines to get each line as a potential item
//     var lines = text.split('\n');
//
//     // Define a list to hold all the bill items
//     List<BillItem> items = [];
//
//     // Regular expression to match a line with item and price
//     var itemPriceRegex = RegExp(r'^(.+?)\s+(\d+\.\d{2})$');
//
//     for (var line in lines) {
//       // Check if the line matches the item and price format
//       var matches = itemPriceRegex.firstMatch(line);
//       if (matches != null && matches.groupCount == 2) {
//         print('here');
//         // Extract the item name and price
//         var itemName = matches.group(1)!.trim();
//         var itemPrice = matches.group(2)!.trim();
//         print('here1');
//         // Add the item to the list
//         items.add(BillItem(name: itemName, price: itemPrice, isSelected: false));
//       }
//     }
//
//     return items;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scanned Bill Items'),
//       ),
//       body: ListView.builder(
//         itemCount: billItems.length,
//         itemBuilder: (context, index) {
//           var item = billItems[index];
//           return ListTile(
//             title: Text(item.name),
//             trailing: Text(item.price),
//             leading: Checkbox(
//               value: item.isSelected,
//               onChanged: (bool? newValue) {
//                 setState(() {
//                   item.isSelected = newValue!;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class BillItem {
//   String name;
//   String price;
//   bool isSelected;
//
//   BillItem({required this.name, required this.price, required this.isSelected});
// }






import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;
  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Recognition Sample'),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(child: Text(text)),
      ),
    );
  }
}