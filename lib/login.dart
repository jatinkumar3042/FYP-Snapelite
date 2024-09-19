import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login/darsbord.dart';
import 'package:login/photographer_profile.dart';

import 'package:login/signup.dart';
import 'package:login/user_profile.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController numberController = TextEditingController();
  MaskTextInputFormatter numberMaskFormatter = MaskTextInputFormatter(
      mask: '####-#######', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;

  @override
  initState() {
    super.initState();
    getper();
    initShared();
  }

  Future<void> getper() async {
    await Permission.notification.request();
  }

  Future<void> initShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginuser() async {
    if (numberController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(context, "Fill all fields");
    } else {
      String? did = await FirebaseMessaging.instance.getToken();
      var regbody = {
        "number": numberController.text,
        "password": passwordController.text,
        "deviceid":did.toString()
      };
      try {
        var response = await http.post(
          Uri.parse(alogin),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody),
        );
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status']) {
          var mytoken = jsonResponse['token'];
          prefs.setString('token', mytoken);
          Map<String, dynamic> decodedToken = JwtDecoder.decode(mytoken);
          print(decodedToken);
          prefs.setString('name', decodedToken['name']);
          prefs.setString('cnic', decodedToken['cnic']);
          prefs.setString('number', decodedToken['number']);
          prefs.setString('address', decodedToken['address']);
          prefs.setString('age', decodedToken['age']);
          prefs.setString('password', decodedToken['password']);
          prefs.setString('id', decodedToken['_id']);
          prefs.setString("deviceid", did.toString());
          print(decodedToken['deviceid']);
          if (decodedToken['cat'] == 'ServiceProvider ') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PhotographerProfile()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfile()),
            );
          }
          // Navigate to dashboard on successful login
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => dasboard(token: mytoken)));
        } else {
          showSnackbar(context, 'Something is wrong');
          numberController.clear();
          passwordController.clear();
        }
      } catch (e) {
        print("Error => $e");
        showSnackbar(context, 'Error occurred. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('assets/abclogo.png'),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              "SnapElite",
              style: GoogleFonts.poppins(
                fontSize: 32,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Welcome ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Login Your Account ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: numberController,
                        inputFormatters: [numberMaskFormatter],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          labelText: "Enter Phone",
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          labelText: "Password",
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 280,
                        child: ElevatedButton(
                          onPressed: loginuser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const signup()));
                              },
                              child: Text(
                                "Register",
                                style: GoogleFonts.poppins(
                                    color: Colors.red, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
