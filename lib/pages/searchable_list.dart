import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search As You Type Example'),
        ),
        body: SearchableList(),
      ),
    );
  }
}

class SearchableList extends StatefulWidget {
  @override
  _SearchableListState createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  TextEditingController _searchController = TextEditingController();
  List<String> _data = [
    'Apple',
    'Banana',
    'Orange',
    'Grapes',
    'Strawberry',
    'Watermelon',
    'Pineapple',
    'Mango',
  ];

  List<String> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData.addAll(_data);
  }

  void _filterData(String query) {
    query = query.toLowerCase();
    setState(() {
      _filteredData = _data
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            onChanged: _filterData,
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Type to search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredData[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
