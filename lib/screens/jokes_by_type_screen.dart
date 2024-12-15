import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}// Update the path to where the extension is saved.

class JokesByTypeScreen extends StatefulWidget {
  final String type;

  JokesByTypeScreen({required this.type});

  @override
  _JokesByTypeScreenState createState() => _JokesByTypeScreenState();
}

class _JokesByTypeScreenState extends State<JokesByTypeScreen> {
  List<dynamic> jokes = [];

  @override
  void initState() {
    super.initState();
    fetchJokesByType();
  }

  Future<void> fetchJokesByType() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/jokes/${widget.type}/ten'));
    if (response.statusCode == 200) {
      List<dynamic> jokeList = json.decode(response.body);
      setState(() {
        jokes = jokeList;
      });
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jokes: ${widget.type.capitalize()}')), // Use the capitalize method here
      body: jokes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(jokes[index]['setup'], style: TextStyle(fontSize: 16)),
              subtitle: Text(jokes[index]['punchline'], style: TextStyle(fontSize: 14, color: Colors.black54)),
            ),
          );
        },
      ),
    );
  }
}
