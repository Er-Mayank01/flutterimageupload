import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http_parser/http_parser.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        onPressed: () async {
          File image;
          final pickedFile =
              await ImagePicker().getImage(source: ImageSource.gallery);
          if (pickedFile == null) {
            setState(() {
              image = File(pickedFile.path);
            });
          }
          try {
            // String filename = image.path.split('/').last;
            FormData formData = FormData.fromMap(
                {"image": await MultipartFile.fromFile(image.path)});
            Response response =
                await dio.post('http://18.222.140.90/api/prescription/upload',
                    data: formData,
                    options: Options(
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization': 'Bearer ' + ''
                      },
                    ));
            print(response.statusCode);
          } catch (e) {
            print(e);
          }
        },
        child: Text('Upload Image'),
      ),
    );
  }
}
