import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage()async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera,imageQuality: 80);
    if(pickedFile!=null){
      image = File(pickedFile.path);
      setState(() {

      });
    }
    else{
      print('No image Selected');
    }
  }

  Future<void> uploadImage() async{
      setState(() {
        showSpinner = true;
      });
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();

      var length = await image!.length();
      var uri = Uri.parse('https://fakestoreapi.com/products');
      var request = new http.MultipartRequest('POST', uri);
      
      request.fields['title'] = 'Static title';
      var multiport = new http.MultipartFile('image', stream, length);

      request.files.add(multiport);
      var response = await request.send();
      if(response.statusCode==200){
        setState(() {
          showSpinner=false;
        });
        print('Image uploaded');
      }
      else{
        setState(() {
          showSpinner = false;
        });
        print('Upload Failed');
      }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null
                    ? Center(
                        child: Text('Pick Image'),
                      )
                    : Container(
                        child: Center(
                            child: Image.file(
                          File(image!.path).absolute,
                          height: 100,
                          width: 100,
                        )),
                      ),

              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.blue,

              ),
            )
          ],
        ),
      ),
    );
  }
}
