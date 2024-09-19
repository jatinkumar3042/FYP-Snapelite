import 'dart:convert';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login/config.dart';
import 'package:login/main.dart';
import 'package:login/photographer_profile.dart';

import 'add_service.dart';

class bookingview extends StatefulWidget {
  const bookingview({super.key, required this.type});
  final String type;

  @override
  State<bookingview> createState() => _bookingviewState();
}

class _bookingviewState extends State<bookingview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: widget.type == "user"
              ? ApiHelper.allbookbybid(prefs.getString("id").toString())
              : ApiHelper.allbookbyuid(prefs.getString("id").toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: const Offset(2, 2))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                                future: ApiHelper.getonuser(
                                    snapshot.data[index]['uid']),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                      width: screenWidth(context),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            child: FutureBuilder(
                                              future: ApiHelper.getonepho(
                                                  snapshot.data["_id"]),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot2) {
                                                if (snapshot2.hasData) {
                                                  return (snapshot2.data['img'].toString().isNotEmpty) &&
                                                      (snapshot2.data['img']
                                                              .toString() !=
                                                          "null")
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.memory(
                                                              base64Decode(
                                                                  snapshot2
                                                                          .data[
                                                                      'img']),
                                                              width: 50,
                                                              height: 50,
                                                              fit:
                                                                  BoxFit.cover),
                                                        )
                                                      : const SizedBox.shrink();
                                                } else if (snapshot2.hasError) {
                                                  return const Icon(
                                                    Icons.error,
                                                  );
                                                } else {
                                                  return const CircularProgressIndicator();
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Name: ${snapshot.data['name']}\nNumber: ${snapshot.data['number']} ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 11),
                                              maxLines: 15,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Icon(
                                      Icons.error,
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              )),
                          FutureBuilder(
                            future: ApiHelper.getoneservices(
                                snapshot.data[index]['sid']),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: CardWidget(
                                    data: snapshot.data,
                                  ),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "status : " + snapshot.data[index]['status'],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    double.parse(snapshot.data[index]['lat']),
                                    double.parse(snapshot.data[index]['lon'])),
                                zoom: 15.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId('marker'),
                                  position: LatLng(
                                      double.parse(snapshot.data[index]['lat']),
                                      double.parse(
                                          snapshot.data[index]['lon'])),
                                ),
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          widget.type != "user" &&
                                  snapshot.data[index]['status'] == "new"
                              ? ElevatedButton(
                                  onPressed: () async {
                                    await ApiHelper.changestatus(
                                        snapshot.data[index]['_id'], "accept");
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.red, // Change the color to red
                                  ),
                                  child: const Text(
                                    "accept",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))
                              : widget.type == "user" &&
                                      snapshot.data[index]['status'] == "accept"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await ApiHelper.changestatus(
                                            snapshot.data[index]['_id'],
                                            "done");
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .red, // Change the color to red
                                      ),
                                      child: const Text("done",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)))
                                  : const SizedBox.shrink(),
                          widget.type == "user" &&
                                  snapshot.data[index]['status'] == "done"
                              ? ElevatedButton(
                                  onPressed: () {
                                    addreview(
                                        context, snapshot.data[index]['uid']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green, // Change the color to red
                                  ),
                                  child: const Text("add review",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : const SizedBox.shrink(),
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
      ),
    );
  }

  void addreview(BuildContext context, String id) {
    TextEditingController message = TextEditingController();
    double a = 0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Add Review",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: message,
                    decoration:
                        const InputDecoration(hintText: "Enter your review "),
                  ),
                  AnimatedRatingStars(
                    initialRating: 0,
                    minRating: 0.0,
                    maxRating: 5.0,
                    filledColor: Colors.amber,
                    emptyColor: Colors.grey,
                    filledIcon: Icons.star,
                    halfFilledIcon: Icons.star_half,
                    emptyIcon: Icons.star_border,
                    onChanged: (double rating) {
                      a = rating;
                    },
                    displayRatingValue: true,
                    interactiveTooltips: true,
                    customFilledIcon: Icons.star,
                    customHalfFilledIcon: Icons.star_half,
                    customEmptyIcon: Icons.star_border,
                    starSize: 20,
                    animationDuration: const Duration(milliseconds: 300),
                    animationCurve: Curves.easeInOut,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (message.text.toString().isEmpty || a == 0) {
                          show_snackbar(context, "Fill all fields");
                        } else {
                          displayprogress(context);
                          Map c = await ApiHelper.registerrating(
                            prefs.getString("id").toString(),
                            id,
                            a.toString(),
                            message.text,
                          );
                          hideprogress(context);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // Change the color to red
                      ),
                      child: const Text("add review",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          );
        });
  }
}
