import 'package:flutter/material.dart';
import 'package:flutter_restapi/screens/second_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
  class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    String title = "" ;
    String author = "" ;
  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
           Padding(padding: const EdgeInsets.only(right: 10.0),
          child: Text(author,style: TextStyle(fontSize: 18),)

          ),
          ElevatedButton(onPressed: () async {
            setState(() {
              title = title;
            });
            var url  = Uri.parse('https://testapi.rcf.ph/api/v1/maintenance-state/android');
            var response = await http.get(url);
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            var data = jsonDecode(response.body);
            print(data["message"]);
             author = data["message"] ;
             title = "ting ting ting";
             setState(() {

             });

           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen(message: message)));
          },
            child: const Text("Go to the next screen"),

          ),
          
        ],
      ),

    ),
  );
  }
}