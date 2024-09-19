import 'package:flutter/material.dart';
import 'package:login/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class user_complain extends StatefulWidget {
  const user_complain({super.key});

  @override
  State<user_complain> createState() => _user_complainState();
}

class _user_complainState extends State<user_complain> {
  @override
  final String contactNumber = '03493321304';
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text('Complain',style: TextStyle(color: Colors.blueGrey,),),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserProfile()));
          },
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: [
                  Center(child: Text("Process Booking Issue",
                    style: TextStyle(fontSize: 16,color: Colors.blueGrey,fontWeight: FontWeight.w600),)),
                  SizedBox(height: 10,),
                  SizedBox( child: Center(child: IconButton(onPressed: (){
                    launch('tel:$contactNumber');
                  }, style: IconButton.styleFrom(backgroundColor: Colors.blueGrey),
                      icon: Icon(Icons.book_online_rounded,size: 160,color: Colors.white,)))),
                  SizedBox(height: 12,),
                  Container( decoration: BoxDecoration(  border: Border( top: BorderSide(color: Colors.blueGrey, width: 0.7),

                  ),
                  ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text("Payment Issue",
                    style: TextStyle(fontSize: 16,color: Colors.blueGrey,fontWeight: FontWeight.w600),)),
                  SizedBox(height: 10,),
                  SizedBox( child: Center(child: IconButton(onPressed: (){
                    launch('tel:$contactNumber');
                  }, style: IconButton.styleFrom(backgroundColor: Colors.blueGrey),
                      icon: Icon(Icons.payments,size: 160,color: Colors.white,)))),
                  SizedBox(height: 12,),
                  Container( decoration: BoxDecoration(  border: Border( top: BorderSide(color: Colors.blueGrey, width: 0.7),

                  ),
                  ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text("Service Quality",style: TextStyle(fontSize: 16,color: Colors.blueGrey,fontWeight: FontWeight.w600),)),
                  SizedBox(height: 10,),
                  SizedBox( child: Center(child: IconButton(onPressed: (){
                    launch('tel:$contactNumber');
                  }, style: IconButton.styleFrom(backgroundColor: Colors.blueGrey),
                      icon: Icon(Icons.design_services,size: 160,color: Colors.white,)))),
                  SizedBox(height: 12,),
                  Container( decoration: BoxDecoration(  border: Border( top: BorderSide(color: Colors.black, width: 0.7),

                  ),
                  ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Text("Privacy and Security",style: TextStyle(fontSize: 16,color: Colors.blueGrey,fontWeight: FontWeight.w600),)),
                  SizedBox(height: 10,),
                  SizedBox( child: Center(child: IconButton(onPressed: (){
                    launch('tel:$contactNumber');
                  }, style: IconButton.styleFrom(backgroundColor: Colors.blueGrey),
                      icon: Icon(Icons.security,size: 160,color: Colors.white,)))),
                  SizedBox(height: 12,),
                  Container( decoration: BoxDecoration(  border: Border( top: BorderSide(color: Colors.blueGrey, width: 0.7),),),),

                  SizedBox(height: 20,),
                  Center(child: Text("Unprofessional Behavior",
                    style: TextStyle(fontSize: 16,color: Colors.blueGrey,fontWeight: FontWeight.w600),)),
                  SizedBox(height: 10,),
                  SizedBox( child: Center(child: IconButton(onPressed: (){
                    launch('tel:$contactNumber');
                  }, style: IconButton.styleFrom(backgroundColor: Colors.blueGrey),
                      icon: Icon(Icons.person_off,size: 160,color: Colors.white,)))),
                  SizedBox(height: 12,),
                  Container( decoration: BoxDecoration(  border: Border( top: BorderSide(color: Colors.blueGrey, width: 0.7),),),),

                  SizedBox(height: 20,),
                  Center(child: Text("Any Other Query",style: TextStyle(fontSize: 16,color: Colors.blueGrey,fontWeight: FontWeight.w600),)),
                  SizedBox(height: 10,),
                  SizedBox( child: Center(child: IconButton(onPressed: (){
                    launch('tel:$contactNumber');
                  }, style: IconButton.styleFrom(backgroundColor: Colors.blueGrey),
                      icon: Icon(Icons.query_stats,size: 160,color: Colors.white,)))),
                  SizedBox(height: 12,),


                ],
              ),
            ),
          ],
        )
    );
  }
}
