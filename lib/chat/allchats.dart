import 'package:flutter/material.dart';

import '../config.dart';
import '../main.dart';
import 'chatting.dart';

class allchats extends StatefulWidget {
  const allchats({super.key,this.c = true});
  final bool c;

  @override
  State<allchats> createState() => _allchatsState();
}

class _allchatsState extends State<allchats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.c? AppBar(
          backgroundColor: Colors.red,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("All Chat",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ):null,
        body: FutureBuilder(
          future:
          ApiHelper.allchatbydid(prefs.getString("id").toString()),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => chatting(
                            id: snapshot.data[index]['_id']??"",
                            did: snapshot.data[index]['did']??"",
                          ),),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green[100],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: ApiHelper.getonuser(
                                  snapshot.data[index]['uid']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot2) {
                                if (snapshot2.hasData) {
                                  return Text(snapshot2.data['name'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  );
                                } else if (snapshot2.hasError) {
                                  return const Icon(
                                    Icons.error,
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                            Text(snapshot.data[index]['date']
                                    .toString()
                                    .substring(0, 10),
                                style: const TextStyle(fontSize: 10),),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return const Icon(
                Icons.error,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
