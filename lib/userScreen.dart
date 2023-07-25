import 'dart:convert';

import 'package:apitutorial/Models/UserModel.dart';
import 'package:apitutorial/user_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userList=[];
  Future<List<UserModel>> getUserApi ()async{
    final response =await http.get(Uri.parse(' '));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        // print(i);
        // print('name');
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User List'),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context,index){
                      return Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ReusableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                            ReusableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                            ReusableRow(title: 'Address', value: snapshot.data![index].address!.city.toString()),
                          ],
                        ),
                      );
                    });
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

