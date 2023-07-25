import 'dart:convert';

import 'package:apitutorial/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexScreen extends StatefulWidget {
  const ComplexScreen({Key? key}) : super(key: key);

  @override
  State<ComplexScreen> createState() => _ComplexScreenState();
}

class _ComplexScreenState extends State<ComplexScreen> {
    var data;
  Future<void> getUserApi ()async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200){
      data = jsonDecode(response.body.toString());

    }else{
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complex List'),),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,snapshot){
               if(snapshot.connectionState==ConnectionState.waiting){
                 return CircularProgressIndicator();
               }
               else{
                 return ListView.builder(
                   itemCount: data.length,
                   itemBuilder: (context,index){
                     return Card(
                       child: Column(
                         children: [
                           ReusableRow(title: 'Name: ', value: data[index]['name'].toString()),
                             ReusableRow(title: 'Username: ', value: data[index]['username'].toString()),
                             ReusableRow(title: 'Address: ', value: data[index]['address']['street'].toString()),
                             ReusableRow(title: 'Lat: ', value: data[index]['address']['geo']['lat'].toString()),

                         ],
                       ),
                     );
                   },

                 );
               }
            },
          ))
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title,value;

  ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
