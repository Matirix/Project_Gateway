import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // Define your state variables here
  int _selectedSortByIndex = 0;
  final List<bool> _selectedFilterByOptions = [false, false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    // Initialize your state variables here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                      value: 2,
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
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: Text(
                  "Filter By:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: Text(
                  "Urgency",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF187187)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: _selectedFilterByOptions[0],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedFilterByOptions[0] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "High Risk",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    CheckboxListTile(
                      value: _selectedFilterByOptions[1],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedFilterByOptions[1] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Moderate Risk",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    CheckboxListTile(
                      value: _selectedFilterByOptions[2],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedFilterByOptions[2] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Low Risk",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: Text(
                  "Topic",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF187187)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: _selectedFilterByOptions[3],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedFilterByOptions[3] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Allergies",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    CheckboxListTile(
                      value: _selectedFilterByOptions[4],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedFilterByOptions[4] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Injuries",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    CheckboxListTile(
                      value: _selectedFilterByOptions[5],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedFilterByOptions[5] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Chronic Illness",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    CheckboxListTile(
                      value: _selectedFilterByOptions[6],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedFilterByOptions[6] = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Testing",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _selectedSortByIndex);
        },
        // child: Text("Apply"),
        child: const Icon(Icons.check),
      ),
    );
  }
}
