import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'jokes_by_type_screen.dart';
import 'random_joke_screen.dart';

class JokeTypesScreen extends StatefulWidget {
  @override
  _JokeTypesScreenState createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    fetchJokeTypes();
  }

  Future<void> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/types'));
    if (response.statusCode == 200) {
      List<String> types = List<String>.from(json.decode(response.body));
      setState(() {
        jokeTypes = types;
      });
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.casino),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: jokeTypes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: jokeTypes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(jokeTypes[index], style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JokesByTypeScreen(type: jokeTypes[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
