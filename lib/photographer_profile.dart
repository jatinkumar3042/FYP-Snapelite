import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/add_service.dart';
import 'package:login/addwork.dart';
import 'package:login/bookingview.dart';
import 'package:login/chat/allchats.dart';
import 'package:login/complain.dart';
import 'package:http/http.dart' as http;
import 'package:login/eidit_profile.dart';
import 'package:login/main.dart';

import 'config.dart';
import 'login.dart';

class PhotographerProfile extends StatefulWidget {
  final token;
  const PhotographerProfile({@required this.token, Key? key}) : super(key: key);

  @override
  State<PhotographerProfile> createState() => _PhotographerProfileState();
}

class _PhotographerProfileState extends State<PhotographerProfile> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getAppBarTitle(),
        automaticallyImplyLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_currentIndex == 0) {
            return true;
          } else {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            return false; // Prevent default back action
          }
        },
        child: PageView(
          controller: _pageController,
          children: [
            FutureBuilder(
              future: getbyid(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            CardWidget(
                              data: snapshot.data[index],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () async {
                                    displayprogress(context);
                                    await ApiHelper.deleteservice(
                                        snapshot.data[index]['_id']);
                                    setState(() {});
                                    hideprogress(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.red,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(3),
                                    child: const Center(
                                        child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                )),
                                Expanded(
                                    child: InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => add_service(
                                                  data: snapshot.data[index]
                                                      as Map,
                                                )));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.green,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(3),
                                    child: const Center(
                                        child: Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ))
                              ],
                            )
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder(
              future: workbyiddd(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.memory(
                                  base64Decode(snapshot.data[index]['img']),
                                  width: screenWidth(context),
                                  fit: BoxFit.cover),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data[index]['name'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ));
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const allchats(c: false),
            const bookingview(type: "taker"),
            FutureBuilder(
              future: getUserData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blueGrey[900],
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: Column(children: [
                              InkWell(
                                onTap:()=> pickImage(ImageSource.gallery),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: snapshot.data['img'] != ""?Image.memory(
                                      base64Decode(snapshot.data['img']),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ):const Icon(Icons.person,color: Colors.white,size: 80,),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                prefs.getString("name")!,
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(6.5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'About me',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    snapshot.data['bio'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 0.7),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    'E-mail',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    snapshot.data['email'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 0.7),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Experince',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    snapshot.data['exp'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 0.7),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Facebook',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    snapshot.data['Work'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 0.7),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Others Link',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    snapshot.data['socialmedia'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ));
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                    "PLEASE EDIT YOUR PROFILE",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work,
              color: Colors.black,
            ),
            label: 'Work',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.black,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.border_all_sharp,
              color: Colors.black,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  File? pickedImage;
  XFile? pickedFile;

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
        pickedFile = photo;
      });

      String data = await convertImageToBase64(pickedFile);
      bool cc = await ApiHelper.updateproviderimg(
          prefs.getString("id").toString(), data, context);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<String> convertImageToBase64(XFile? pickedFile) async {
    if (pickedFile == null) return "";
    final bytes = await pickedFile.readAsBytes();
    return base64Encode(bytes);
  }

  Widget _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            prefs.getString("name")!,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_box_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const add_service()));
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const complain()));
                },
                icon: const Icon(
                  Icons.help_center_rounded,
                  color: Colors.blue,
                ))
          ],
        );
      case 1:
        return AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Pervious Work",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.grid_3x3_outlined),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const addwork()));
              },
            ),
          ],
        );
      case 2:
        return AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Provider Profile View",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const eidit_profile()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                prefs.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        );

      default:
        return const Text('');
    }
  }

  Future<Map> getUserData() async {
    var response = await http.post(
      Uri.parse(getone),
      body: jsonEncode({"userId": prefs.getString("id")}),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body);
    return data['data'];
  }

  Future<List> getbyid() async {
    var response = await http.post(
      Uri.parse(getbyidlink),
      body: jsonEncode({"userId": prefs.getString("id")}),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body);
    return data['data'];
  }

  Future<List> workbyiddd() async {
    var response = await http.post(
      Uri.parse(workbyid),
      body: jsonEncode({"uid": prefs.getString("id")}),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body);
    return data['data'];
  }
}

class CardWidget extends StatefulWidget {
  var data;
  var m = false;
  var uid = "";
  var bid = "";

  CardWidget(
      {required this.data, this.m = false, this.uid = "", this.bid = ""});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: double.infinity,
        height: widget.m ? 160 : 110.0,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.data.isNotEmpty
                    ? Text(
                        "Name: ${widget.data['name']}\nDescription: ${widget.data['des']}\nPrice: ${widget.data['price']}.\nTime: ${widget.data['duration']} ",
                        style: const TextStyle(fontSize: 11.0),
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const Text(
                        "Create Your First Service\n by creating on plus icon on top bar",
                        style: TextStyle(fontSize: 14.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widget.m
                ? InkWell(
                    onTap: () async {

                      await selectDate(context);
                      await selectTime(context);

                      displayprogress(context);
                      Map d = await addloc();
                      bool a = await ApiHelper.registerbook(
                          widget.uid, widget.bid, widget.data['_id'], d['lat'], d['lon'],
                        "$selectedDate ${selectedTime!.format(context)}"
                      );

                      Map ud = await ApiHelper.getonuser(widget.uid);
                      NotificationService.sendNotification(
                          ud['deviceid'], "New Booking", "Booked Sucessfully");

                      hideprogress(context);
                      if (a) {
                        NotificationService.sendNotification(
                            prefs.getString("deviceid").toString(),
                            "Booked",
                            "Booked Sucessfully");
                        show_snackbar(context, "Booked Sucessfully");
                        Navigator.pop(context);
                      } else {
                        NotificationService.sendNotification(
                            prefs.getString("deviceid").toString(),
                            "Booked unsucessfully",
                            "Booked Sucessfully");
                        show_snackbar(context, "Booked UnSucessfully");
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.red,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(3),
                      child: const Center(
                          child: Text(
                        "Book Now",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Future<Map> addloc() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position p = await Geolocator.getCurrentPosition();
    return {"lat": p.latitude.toString(), "lon": p.longitude.toString()};
  }

  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(

    context: context,
    initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
    setState(() {
      selectedDate = pickedDate;
    });
    }
  }
}
