import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/photographer_profile.dart';
import 'package:login/signup.dart';
import 'package:login/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class category extends StatefulWidget {
  const category({super.key});
  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  String userName = "";
  String userCnic = "";
  String userNumber = "";
  String userAddress = "";
  String userAge = "";
  String userPassword = "";

  @override
  void initState() {
    super.initState();
    setState(() {});
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedName = prefs.getString('name');
    String? saveCnic = prefs.getString('cnic');
    String? saveNumber = prefs.getString('number');
    String? saveAddress = prefs.getString('address');
    String? saveAge = prefs.getString('age');
    String? savePassword = prefs.getString('password');

    setState(() {
      userName = savedName ?? "";
      userCnic = saveCnic ?? "";
      userNumber = saveNumber ?? "";
      userAddress = saveAddress ?? "";
      userAge = saveAge ?? "";
      userPassword = savePassword ?? "";
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Row(
          children: [
            SizedBox(
              height: 70,
              width: 60,
              child: Image.asset("assets/abclogo.png"),
            ),
            Text("Category",
              style: GoogleFonts.poppins(fontSize: 25, color: Colors.black,),
            )
          ],
        ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0), // Adjust the height of the border line
            child: Container(
              color: Colors.red,
              height: 3.0,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsetsDirectional.all(10),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      shadowColor: selectedCategory == 'ServiceProvider'? Colors.red:Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(
                            child: TextButton(
                              onPressed: () =>
                                  handleCategoryButtonClick('ServiceProvider'),
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide.none),
                              child: ListTile(
                                title: Text(
                                  "Service Provider",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    "In this category you can Provider services from other peoples ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.start,
                                    softWrap: true),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.white,
                      shadowColor: selectedCategory == 'ServiceTaker'? Colors.blue:Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(
                            child: TextButton(
                              onPressed: () =>
                                  handleCategoryButtonClick('ServiceTaker'),
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide.none),
                              child: ListTile(
                                title: Text(
                                  "Service Taker",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    "In this category you can Take service from other peoples ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.start,
                                    softWrap: true),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 240,
                      child: ElevatedButton(
                          onPressed: selectedCategory.isNotEmpty
                              ? () => {handleNextButtonClick()}
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: LinearBorder.bottom()),
                          child: Text('NEXT',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, color: Colors.white))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  String selectedCategory = '';
  void handleCategoryButtonClick(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Future<void> handleNextButtonClick() async {
    String? did = await FirebaseMessaging.instance.getToken();
    prefs.setString("deviceid", did.toString());
    if (selectedCategory == 'ServiceProvider') {
      var regbody = {
        "name": userName,
        "cnic": userCnic,
        "number": userNumber,
        "address": userAddress,
        "age": userAge,
        "password": userPassword,
        "cat": "ServiceProvider ",
        "deviceid": did.toString()
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      prefs.setString("id", data['data']["_id"]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PhotographerProfile()),
      );
    } else if (selectedCategory == 'ServiceTaker') {
      var regbody = {
        "name": userName,
        "cnic": userCnic,
        "number": userNumber,
        "address": userAddress,
        "age": userAge,
        "password": userPassword,
        "cat": "ServiceTaker ",
        "deviceid": did.toString()
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      prefs.setString("id", data['data']["_id"]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfile()),
      );
    }
  }
}
