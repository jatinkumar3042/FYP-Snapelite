import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/categrory.dart';
import 'package:login/login.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

late SharedPreferences prefs;

class _signupState extends State<signup> {
  @override
  @override
  void initState() {
    super.initState();
    setState(() {});
    initPreferences();
  }

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  MaskTextInputFormatter cnicMaskFormatter = MaskTextInputFormatter(
      mask: '#####-#######-#', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController numberController = TextEditingController();
  MaskTextInputFormatter numberMaskFormatter = MaskTextInputFormatter(
      mask: '####-#######', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CpasswordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              height: 100, width: 100, child: Image.asset('assets/abclogo.png')),
          const SizedBox(
            height: 5,
          ),
          Center(
              child: Text("SnapElite",
                  style: GoogleFonts.poppins(
                      fontSize: 30, color: Colors.black))),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsetsDirectional.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person,color: Colors.black,),
                            labelText: "Enter Name",
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: cnicController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [cnicMaskFormatter],
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.document_scanner,color: Colors.black,),
                            labelText: "CNIC",
                          ),
                        ),
                        TextFormField(
                          controller: numberController,
                          inputFormatters: [
                            numberMaskFormatter
                          ], // Use the correct formatter here
                          keyboardType: TextInputType.number,

                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone,color: Colors.black,),
                            labelText: "Enter Phone",
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.home,color: Colors.black,),
                            labelText: "Enter Address",
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person,color: Colors.black,),
                            labelText: "Enter Age",
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password,color: Colors.black,),
                            labelText: "Password",
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: CpasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password,color: Colors.black,),
                            labelText: "Confirm Password",
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 280,
                          child: ElevatedButton(
                              onPressed: () {
                                input();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: LinearBorder.bottom()),
                              child: Text("Sign Up",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18, color: Colors.white))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already Signup Click to",style: TextStyle(color: Colors.black,fontSize: 17),),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: Text(
                                  "here",
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 17,
                                  ),
                                )),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void input() {
    if (nameController.text.isEmpty ||
        cnicController.text.isEmpty ||
        numberController.text.isEmpty ||
        addressController.text.isEmpty ||
        ageController.text.isEmpty ||
        passwordController.text.isEmpty ||
        CpasswordController.text.isEmpty) {
      showSnackbar(context, "Fill are feilds");
    } else if (numberController.text.toString().length != 12) {
      showSnackbar(context, "Check the mobile number");
    } else if (cnicController.text.toString().length != 15) {
      showSnackbar(context, "Check the Cnic number ");
    } else if (CpasswordController.text != passwordController.text) {
      showSnackbar(context, "Password and Confirm Password do not Match");
    } else {
      prefs.setString('name', nameController.text);
      prefs.setString('cnic', cnicController.text);
      prefs.setString('number', numberController.text);
      prefs.setString('address', addressController.text);
      prefs.setString('age', ageController.text);
      prefs.setString('password', passwordController.text);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const category()));
    }
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }
}
