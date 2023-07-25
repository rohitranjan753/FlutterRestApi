import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login API"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passController,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {
            login(emailController.text.toString(),passController.text.toString());
          }, child: Text("REGISTER"))
        ],
      ),
    );
  }

  void login(String email, String pass) async {
    try{
      Response response =await post(Uri.parse('https://reqres.in/api/register'),
      body: {
        'email':email,
        'password':pass,
      },);
      if(response.statusCode==200){
        print('Account created successfully');
      }
      else{
        print('Failed');
      }
    }
        catch(e){
      print(e.toString());
        }
  }
}
