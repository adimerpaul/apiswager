import 'dart:convert';

import 'package:api_crud/page/AddPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List datos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatos();
  }

  getDatos() async {
    var url = await Uri.parse('https://api.nstack.in/v1/todos');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['items'];
      // print(data);
      setState(() {
        datos = data;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: ListView.builder(
        itemCount: datos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(datos[index]['title']),
            subtitle: Text(datos[index]['description']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(builder: (context) => AddPage());
          await Navigator.push(context, route);
          getDatos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
