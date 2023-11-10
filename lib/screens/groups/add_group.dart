import 'package:flutter/material.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('MoneyPot Name', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page or perform other actions
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // Using Expanded here to allow the ListView to take up all available space
            child: ListView.builder(
              itemCount: 10, // Replace with your dynamic content count
              itemBuilder: (BuildContext context, int index) {
                // Replace with your custom ListTile or another widget for content
                return ListTile(
                  title: Text('Person ${index + 1}'),
                  subtitle: Text('@username-${index + 1}'),
                  trailing: Icon(Icons.check_circle_outline),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle group creation
              },
              child: Text('Create Group'),
            ),
          ),
        ],
      ),
    );
  }
}

