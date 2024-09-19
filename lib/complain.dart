import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/photographer_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class complain extends StatefulWidget {
  const complain({super.key});

  @override
  State<complain> createState() => _complainState();
}

class _complainState extends State<complain> {
  final String contactNumber = '03493321304';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text('Complain',style: TextStyle(color: Colors.black,),),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PhotographerProfile() ));},
          ),
        ),
        body: ListView(
            children: [
              SizedBox(height: 30,),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(


                      child:  Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launch('tel:$contactNumber');
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.book_online_rounded,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            'Booking Issue',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                GestureDetector(
                                  onTap: () {
                                    launch('tel:$contactNumber');
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.payments_rounded,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            'Payment Issue',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),


                              ],

                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.design_services,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Service Quality',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                GestureDetector(
                                  onTap: () {
                                    launch('tel:$contactNumber');
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.security,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Privacy and Security',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),


                              ],

                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launch('tel:$contactNumber');

                                  },
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person_off,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Unprofessional Behavior',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                GestureDetector(
                                  onTap: () {
                                    launch('tel:$contactNumber');
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.query_stats,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Any Other Query',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),


                              ],

                            ),
                            SizedBox(height: 30,),



                          ]
                      )
                  )
              )
            ]
        )
    );

  }
}
