import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:login/config.dart';
import 'package:login/photographer_profile.dart';

import 'main.dart';

class addwork extends StatefulWidget {
  const addwork({super.key});

  @override
  State<addwork> createState() => _addworkState();
}

class _addworkState extends State<addwork> {
  TextEditingController name = TextEditingController();

  File? _image;
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Work"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>PhotographerProfile())); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _image == null
                ? InkWell(
              onTap: () => getImage(),
              child: const Icon(
                Icons.person,
                size: 50,
              ),
            )
                : InkWell(
              onTap: () => getImage(),
              child: Image.file(
                _image!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.medical_services_outlined),
                labelText: "Enter work title",
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Select a image'),
                        ),
                      );
                    } else if (name.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter name'),
                        ),
                      );
                    } else {
                      String c = await convertImageToBase64(_image);
                      var response = await http.post(Uri.parse(registerwork),
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({ "uid": prefs.getString("id"),"img": c,"name": name.text}));
                      var data = jsonDecode(utf8.decode(response.bodyBytes));
                      if (data['status']) {
                        _image = null;
                        name.clear();
                        setState(() {});
                        NotificationService.sendNotification(
                            prefs.getString("deviceid").toString(),
                            "Work",
                            "Work Added Sucessfully");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Work added successfully'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went wrong'),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: LinearBorder.bottom()),
                  child: const Text('Add Work',
                      style:
                      TextStyle(fontSize: 18, color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> convertImageToBase64(File? pickedFile) async {
    if (pickedFile == null) return "";
    final bytes = await pickedFile.readAsBytes();
    return base64Encode(bytes);
  }
}
