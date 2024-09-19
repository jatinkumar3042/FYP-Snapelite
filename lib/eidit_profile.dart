import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/config.dart';
import 'package:login/main.dart';
import 'package:login/photographer_profile.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class eidit_profile extends StatefulWidget {
  final token;
  const eidit_profile({@required this.token, Key? key}) : super(key: key);

  @override
  State<eidit_profile> createState() => _eidit_profileState();
}

class _eidit_profileState extends State<eidit_profile> {
  TextEditingController photoEmail = TextEditingController();
  TextEditingController photoBio = TextEditingController();
  TextEditingController photoExperience = TextEditingController();
  TextEditingController photoFacebook = TextEditingController();
  TextEditingController photoLinks = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  String img = '';
  void getUserData() async {
    var response = await http.post(
      Uri.parse(getone),
      body: jsonEncode({"userId": prefs.getString("id")}),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body);
    photoEmail.text = data['data']['email'];
    photoBio.text = data['data']['bio'];
    photoExperience.text = data['data']['exp'];
    photoFacebook.text = data['data']['Work'];
    photoLinks.text = data['data']['socialmedia'];
    img = data['data']['img'];
    setState(() {});
    print(img);
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Edit profile",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 45,
              ),
              img == ""
                  ? _image == null
                      ? InkWell(
                          onTap: () => getImage(),
                          child: const Icon(
                            Icons.person,color: Colors.black,
                            size: 50,
                          ),
                        )
                      : InkWell(
                          onTap: () => getImage(),
                          child: Image.file(
                            _image!,
                            width: 100,
                            height: 100,
                          ),
                        )
                  : _image != null
                      ? InkWell(
                          onTap: () => getImage(),
                          child: const Icon(
                            Icons.person,color: Colors.black,
                            size: 50,
                          ),
                        )
                      : InkWell(
                          onTap: () => getImage(),
                          child: Image.memory(base64Decode(img),
                              width: 100, height: 100, fit: BoxFit.cover),
                        ),
              const SizedBox(
                height: 45,
              ),
              TextFormField(
                controller: photoEmail,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email,color: Colors.black,),
                  labelText: "Email",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: photoBio,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person,color: Colors.black,),
                  labelText: "Bio",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: photoExperience,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.work_outline,color: Colors.black,),
                  labelText: "Experience",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: photoFacebook,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.facebook,color: Colors.black,),
                  labelText: "Facebook",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: photoLinks,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.link,color: Colors.black,),
                  labelText: "Others Link",
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: 280,
                child: ElevatedButton(
                  onPressed: (){
                    photographerservice();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PhotographerProfile()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Update Profile ",
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Future<void> photographerservice() async {
    String c = img;
    if (_image != null) {
      c = await convertImageToBase64(_image);
    }
    var regbody = {
      "userId": prefs.getString("id"),
      "img": c,
      "email": photoEmail.text,
      "bio": photoBio.text,
      "exp": photoExperience.text,
      "Work": photoFacebook.text,
      "socialmedia": photoLinks.text,
    };
    if (photoEmail.text.isNotEmpty) {
      var response = await http.post(Uri.parse(photographer_service),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
    }
  }

  Future<String> convertImageToBase64(File? pickedFile) async {
    if (pickedFile == null) return "";
    final bytes = await pickedFile.readAsBytes();
    return base64Encode(bytes);
  }
}
