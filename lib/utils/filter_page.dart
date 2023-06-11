import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // Define your state variables here
  int _selectedSortByIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize your state variables here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Page'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Sort By:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: _selectedSortByIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedSortByIndex = value!;
                      });
                    },
                    title: const Text(
                      "Alphabetical (A - Z)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _selectedSortByIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedSortByIndex = value!;
                      });
                    },
                    title: const Text(
                      "Reverse (Z - A)",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _selectedSortByIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedSortByIndex = value!;
                      });
                    },
                    title: const Text(
                      "Recent Patients",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Filter By:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: _selectedSortByIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedSortByIndex = value!;
                      });
                    },
                    title: const Text(
                      "High Risk",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _selectedSortByIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedSortByIndex = value!;
                      });
                    },
                    title: const Text(
                      "Moderate Risk",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _selectedSortByIndex,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedSortByIndex = value!;
                      });
                    },
                    title: const Text(
                      "Low Risk",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perform any action on filter button press
        },
        child: Icon(Icons.filter_list),
      ),
    );
  }
}
