import 'package:flutter/material.dart';
import 'package:login/main.dart';

import '../config.dart';

class chatting extends StatefulWidget {
  chatting({super.key, required this.id, required this.did});
  String id, did;

  @override
  State<chatting> createState() => _chattingState();
}

class _chattingState extends State<chatting> {
  TextEditingController chat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Chat",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiHelper.allchatbyid(widget.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['c'].toString() == '[]') {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else {
                    List l = List.of(snapshot.data['c']).reversed.toList();
                    return ListView.builder(
                      itemCount: l.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: l[index]['sendby'] == prefs.getString("id")
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    l[index]['sendby'] == prefs.getString("id")
                                        ? Colors.green.shade300
                                        : Colors.amber.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l[index]['mess'].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    l[index]['date']
                                        .toString()
                                        .substring(0, 15),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              )),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter Message",
                        ),
                        controller: chat)),
                InkWell(
                  onTap: () async {
                    await ApiHelper.addchat(
                        widget.id,
                        {
                          "sendby": prefs.getString("id"),
                          "mess": chat.text,
                          "date": DateTime.now().toString()
                        },
                        widget.did);
                    Map d = await ApiHelper.getonuser(widget.did);
                    NotificationService.sendNotification(
                        d['deviceid'], "Chat", chat.text);
                    chat.clear();
                    setState(() {});
                  },
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
