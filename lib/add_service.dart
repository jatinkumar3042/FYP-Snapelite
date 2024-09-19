import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login/config.dart';
import 'package:login/main.dart';
import 'package:login/photographer_profile.dart';
import 'package:http/http.dart' as http;

class add_service extends StatefulWidget {
  final token;
  final Map data;
  const add_service({@required this.token,this.data = const {}, Key? key}) : super(key: key);

  @override
  State<add_service> createState() => _add_serviceState();
}

class _add_serviceState extends State<add_service> {
  @override
  String selectedOption = 'Available';
  TextEditingController SerName = TextEditingController();
  TextEditingController Serdes = TextEditingController();
  TextEditingController SerPric = TextEditingController();
  TextEditingController SerDur = TextEditingController();
  TextEditingController dropdownController = TextEditingController();
  late String userId1;

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      userId1 = jwtDecodedToken['_id'] ?? '';
    } catch (e) {
      print('Error decoding token: $e');
    }

    if(widget.data.isNotEmpty){
      SerName.text = widget.data['name'];
      Serdes.text = widget.data['des'];
      SerPric.text = widget.data['price'];
      SerDur.text = widget.data['duration'];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth(context),
              padding: const EdgeInsetsDirectional.all(10),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Add Service",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    controller: SerName,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.medical_services_outlined,color: Colors.black,),
                      labelText: "Enter Service name" ,
                    ),
                  ),
                  TextFormField(
                    controller: Serdes,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.description,color: Colors.black,),
                      labelText: "Enter Service description",
                    ),
                  ),
                  TextFormField(
                    controller: SerPric,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.price_change,color: Colors.black,),
                      labelText: "Enter Service price",
                    ),
                  ),
                  TextFormField(
                    controller: SerDur,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.timer,color: Colors.black,),
                      labelText: "Enter Duration in hours",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      DropdownButton<String>(
                        value: selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption = newValue!;
                          });
                        },
                        items: <String>['Available', 'Unavailable']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 280,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (widget.data.isNotEmpty){
                          await ApiHelper.updateservice(widget.data['_id'],
                              SerName.text, Serdes.text,
                              SerPric.text, SerDur.text);
                          Navigator.pop(context);
                        } else {
                          addssreg();
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        widget.data.isNotEmpty?"Update Service":"Add Service",
                        style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addssreg() async {

    var regbody = {
      "userId": prefs.getString("id"),
      "name": SerName.text,
      "des": Serdes.text,
      "price": SerPric.text,
      "duration": SerDur.text,
      //"availability": dropdownController.text,
    };
    var response = await http.post(Uri.parse(photographer_add),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regbody));
  }
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
