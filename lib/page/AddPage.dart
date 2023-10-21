import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Page')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text('Title'),
            const SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Description'),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
  Future submit() async {
    var url = await Uri.parse('https://api.nstack.in/v1/todos');
    var response = await http.post(url, body: {
      'title': titleController.text,
      'description': descriptionController.text,
    });
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final data = json['data'];
      print(data);
      Navigator.pop(context);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
