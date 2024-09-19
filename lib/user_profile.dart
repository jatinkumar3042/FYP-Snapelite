import 'dart:convert';
import 'dart:ui';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:login/U_profile.dart';
import 'package:http/http.dart' as http;
import 'package:login/bookingview.dart';
import 'package:login/chat/allchats.dart';
import 'package:login/chat/chatting.dart';
import 'package:login/photographer_profile.dart';
import 'package:login/user_complain.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import 'add_service.dart';
import 'config.dart';
import 'main.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "SnapElite",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),
      body: _currentIndex == 0
          ? PostFeed(c: false)
          : _currentIndex == 1
              ? PostFeed(
                  c: true,
                )
              : _currentIndex == 2
                  ? const allchats(
                      c: false,
                    )
                  : _currentIndex == 3
                      ? const bookingview(
                          type: "user",
                        )
                      : const u_profile(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all_sharp),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.blueGrey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: const YourSidebarWidget(),
    );
  }
}

class PostFeed extends StatefulWidget {
  PostFeed({required this.c, Key? key}) : super(key: key);

  @override
  State<PostFeed> createState() => _PostFeedState();
  bool c;
}

class _PostFeedState extends State<PostFeed> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.c
            ? OutlineSearchBar(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                borderRadius: BorderRadius.circular(10),
                borderWidth: 2,
                hintText: "Search here",
                ignoreSpecialChar: true,
                textEditingController: search,
                onKeywordChanged: (String val) {
                  setState(() {});
                },
              )
            : const SizedBox.shrink(),
        !widget.c
            ? Expanded(
                child: FutureBuilder(
                  future: ApiHelper.getall(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () =>
                                showwork(context, snapshot.data[index]),
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(2, 2),
                                          color: Colors.grey.withOpacity(0.2))
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    snapshot.data[index]['img'] == "null" ||
                                        snapshot.data[index]['img'] == ""?
                                    const SizedBox.shrink():
                                    Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.memory(
                                            base64Decode(
                                                snapshot.data[index]['img']),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                      future: ApiHelper.getonuser(
                                          snapshot.data[index]['userId']),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Name: ${snapshot.data['name']}\nNumber: ${snapshot.data['number']}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 11),
                                                      maxLines: 15,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Icon(
                                            Icons.error,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    )
                                  ],
                                )),
                          );
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
              )
            : const SizedBox.shrink(),
        widget.c
            ? Expanded(
                child: FutureBuilder(
                  future: ApiHelper.getall(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: ApiHelper.getonuser(
                                snapshot.data[index]['userId']),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot2) {
                              if (snapshot2.hasData) {
                                if (search.text.isEmpty) {
                                  return InkWell(
                                    onTap: () =>
                                        showwork(context, snapshot.data[index]),
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(2, 2),
                                                  color: Colors.grey
                                                      .withOpacity(0.2))
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            snapshot.data[index]['img'] == "null" ||
                                                snapshot.data[index]['img'] == ""?
                                            const SizedBox.shrink():
                                            Align(
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.memory(
                                                    base64Decode(snapshot
                                                        .data[index]['img']),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: FutureBuilder(
                                                future: ApiHelper.getonuser(
                                                    snapshot.data[index]
                                                        ['userId']),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Name: ${snapshot.data['name']}\nNumber: ${snapshot.data['number']}} ",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        11),
                                                                maxLines: 15,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return const Icon(
                                                      Icons.error,
                                                    );
                                                  } else {
                                                    return const CircularProgressIndicator();
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                } else if (snapshot2.data['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(search.text.toLowerCase())) {
                                  return InkWell(
                                    onTap: () =>
                                        showwork(context, snapshot.data[index]),
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(2, 2),
                                                  color: Colors.grey
                                                      .withOpacity(0.2))
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.memory(
                                                    base64Decode(snapshot
                                                        .data[index]['img']),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: FutureBuilder(
                                                future: ApiHelper.getonuser(
                                                    snapshot.data[index]
                                                        ['userId']),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Name: ${snapshot.data['name']}\nNumber: ${snapshot.data['number']}} ",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        11),
                                                                maxLines: 15,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return const Icon(
                                                      Icons.error,
                                                    );
                                                  } else {
                                                    return const CircularProgressIndicator();
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              } else if (snapshot2.hasError) {
                                return const Icon(
                                  Icons.error,
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          );
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
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  void showwork(BuildContext context, Map data) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: ApiHelper.getonuser(data['userId']),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: screenWidth(context),
                            child: FutureBuilder(
                              future: ApiHelper.getonepho(data['userId']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot2) {
                                if (snapshot2.hasData) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            child: snapshot2.data['img']
                                                .toString() !=
                                                "null"
                                                ? ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              child: Image.memory(
                                                  base64Decode(
                                                      snapshot2.data['img']),
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover),
                                            )
                                                : const SizedBox.shrink()
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Name: ${snapshot.data['name']}\nNumber: ${snapshot.data['number']} ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 17),
                                              maxLines: 15,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(
                                        snapshot2.data['email'],
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        snapshot2.data['bio'],
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        snapshot2.data['exp'],
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "FB : "+snapshot2.data['Work'],
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Social Media : "+snapshot2.data['socialmedia'],
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  );
                                } else if (snapshot2.hasError) {
                                  return const Icon(
                                    Icons.error,
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            )
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
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () async {
                            Map c = await ApiHelper.registerchat(
                                prefs.getString("id").toString(),
                                data['userId']);
                            if (c['status']) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => chatting(
                                    id: c['message'],
                                    did: c['did'],
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green),
                              child:
                                  const Icon(Icons.chat, color: Colors.white))),
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () => show(context, data),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green),
                              child: const Icon(
                                Icons.work,
                                color: Colors.white,
                              ))),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: ApiHelper.allratingbydid(data['userId']),
                  builder: (BuildContext context, AsyncSnapshot snapshot2) {
                    if (snapshot2.hasData) {
                      if (snapshot2.data.toString() == '[]') {
                        return const SizedBox.shrink();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("All Reviews",
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(
                              width: screenWidth(context),
                              height: 80,
                              child: ListView.builder(
                                itemCount: snapshot2.data.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(2, 2),
                                              blurRadius: 1,
                                              color: Colors.grey.shade200)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AnimatedRatingStars(
                                          initialRating: double.parse(
                                              snapshot2.data[index]['rating']),
                                          minRating: 0.0,
                                          maxRating: 5.0,
                                          filledColor: Colors.amber,
                                          emptyColor: Colors.grey,
                                          filledIcon: Icons.star,
                                          halfFilledIcon: Icons.star_half,
                                          emptyIcon: Icons.star_border,
                                          onChanged: (double rating) {},
                                          displayRatingValue: true,
                                          interactiveTooltips: true,
                                          customFilledIcon: Icons.star,
                                          customHalfFilledIcon: Icons.star_half,
                                          customEmptyIcon: Icons.star_border,
                                          starSize: 10,
                                          animationDuration:
                                          const Duration(milliseconds: 300),
                                          animationCurve: Curves.easeInOut,
                                          readOnly: true,
                                        ),
                                        Text(
                                            snapshot2.data[index]['review'],
                                            style: const TextStyle(
                                              fontSize: 10
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    } else if (snapshot2.hasError) {
                      return const Icon(
                        Icons.error,
                      );
                    } else {
                      return displaysimpleprogress(context);
                    }
                  },
                ),
                Expanded(
                    child: FutureBuilder(
                  future: getbyid(data['userId']),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.toString() == '[]') {
                        return const Center(
                          child: Text("No Data"),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () =>
                                    showwork(context, snapshot.data[index]),
                                child: CardWidget(
                                  data: snapshot.data[index],
                                  m: true,
                                  bid: prefs.getString("id").toString(),
                                  uid: data['userId'],
                                ),
                              );
                            });
                      }
                    } else if (snapshot.hasError) {
                      return const Icon(
                        Icons.error,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )),
              ],
            ),
          );
        });
  }

  void show(BuildContext context, Map data) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Expanded(
              child: FutureBuilder(
                future: workbyiddd(data['userId']),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                        base64Decode(
                                            snapshot.data[index]['img']),
                                        width: 200,
                                        height: 130,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data[index]['name'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
            ),
          );
        });
  }

  Future<List> workbyiddd(String uid) async {
    var response = await http.post(
      Uri.parse(workbyid),
      body: jsonEncode({"uid": uid}),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body);
    return data['data'];
  }

  Future<List> getbyid(id) async {
    var response = await http.post(Uri.parse(getbyuidservices),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": id}));
    var data = jsonDecode(response.body);
    return data['data'];
  }
}

class YourSidebarWidget extends StatelessWidget {
  const YourSidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
            child: Text(
              "Jatin Kumar",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfile()));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.person_outline, color: Colors.black54),
                  SizedBox(width: 8.0),
                  Text(
                    'View Profile',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.photo_camera, color: Colors.black54),
                  SizedBox(width: 8.0),
                  Text(
                    'Book Photographer',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.location_city_sharp, color: Colors.black54),
                  SizedBox(width: 10.0),
                  Text(
                    'Address',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfile()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.security_sharp, color: Colors.black54),
                  const SizedBox(width: 3.0),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const user_complain()));
                      },
                      child: const Text(
                        'Complain',
                        style: TextStyle(color: Colors.orangeAccent),
                      ))
                ],
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.history, color: Colors.black45),
                  SizedBox(width: 8.0),
                  Text(
                    'History',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
