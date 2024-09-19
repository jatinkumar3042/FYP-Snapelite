import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

const url = 'http://10.0.2.2:4000/';
const registration = '${url}registration';
const alogin = '${url}login';
const photographer_service = '${url}photographerservice';
const photographer_add = '${url}registerphotoservice';
const registerwork = '${url}registerwork';
const workbyid = '${url}workbyid';
const updatephotoid = '${url}updatephoto';

const getonuserlink = "${url}getonuser";
const getalllink = "${url}getall";
const getone = '${url}getone';
const getbyidlink = '${url}getbyid';
const getoneserviceslink = '${url}getoneservices';
const getallservices = '${url}getallservices';
const getbyuidservices = '${url}getbyuidservices';
const deleteserviceslink = '${url}deleteservices';
const updateservicelink = '${url}updateservice';

// chat
const registerchatlink = "${url}registerchat";
const allchatbyidlink = "${url}allchatbyid";
const addchatlink = "${url}addchat";
const allchatbydidlink = "${url}allchatbydid";

// book
const registerbooklink = "${url}registerbook";
const allbookbyuidlink = "${url}allbookbyuid";
const allbookbybidlink = "${url}allbookbybid";
const changestatuslink = "${url}changestatus";

// rating
const registerratinglink = "${url}registerrating";
const allratingbydidlink = "${url}allratingbydid";

class ApiHelper{
  static Future<bool> updateproviderimg(
      String id, String img, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatephotoid),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "img": img,
            "userId": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // rating
  static Future<Map> registerrating(
      String uid, String did, String ratings, String review) async {
    try {
      var response = await http.post(Uri.parse(registerratinglink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "did": did,
            "rating": ratings,
            "review": review,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<List> allratingbydid(String did) async {
    try {
      var response = await http.post(Uri.parse(allratingbydidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"did": did}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  // chat
  static Future<Map> registerchat(String uid, String did) async {
    try {
      var response = await http.post(Uri.parse(registerchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "did": did,
            "c": [],
            "date": DateTime.now().toString(),
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> allchatbyid(String id) async {
    try {
      var response = await http.post(Uri.parse(allchatbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> allchatbydid(String did) async {
    try {
      var response = await http.post(Uri.parse(allchatbydidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"did": did}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addchat(String id, Map dataa, String sendto) async {
    try {
      var response = await http.post(Uri.parse(addchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "data": dataa}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // booking
  static Future<bool> registerbook(String uid,String bid, String sid,String lat,
      String lon , String date) async {
    try {
      var response = await http.post(Uri.parse(registerbooklink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "bid": bid,
            "sid": sid,
            "lat": lat,
            "lon": lon,
            "status": "new",
            "date": date,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data["status"];
    } catch (e) {
      return false;
    }
  }

  static Future<List> allbookbyuid(String uid) async {
    try {
      var response = await http.post(Uri.parse(allbookbyuidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> allbookbybid(String sid) async {
    try {
      var response = await http.post(Uri.parse(allbookbybidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"bid": sid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> changestatus(String id,String status) async {
    try {
      var response = await http.post(Uri.parse(changestatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id,"status":status}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // auth
  static Future<Map> getonuser(String number) async {
    try {
      var response = await http.post(
        Uri.parse(getonuserlink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": number}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['user'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> getall() async {
    try {
      var response = await http.post(
        Uri.parse(getalllink),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(data);
      return data['data'];
    } catch (e) {
      return [];
    }
  }


  // photographer
  static Future<Map> getonepho(String number) async {
    try {
      var response = await http.post(
        Uri.parse(getone),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": number}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<void> deleteservice(String id) async {
    try {
      var response = await http.post(
        Uri.parse(deleteserviceslink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {}
  }

  static Future<void> updateservice(String id,name,des,price,duration) async {
    try {
      var response = await http.post(
        Uri.parse(updateservicelink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id,
          "name":name,"des":des,"price":price,"duration":duration
        }),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {}
  }

  // service
  static Future<Map> getoneservices(String id) async {
    try {
      var response = await http.post(
        Uri.parse(getoneserviceslink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id}),
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return {};
    }
  }
}



ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show_snackbar(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget displaysimpleprogress(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(
      strokeWidth: 6.0,
    ),
  );
}

void displayprogress(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 6.0,
          ),
        ),
      );
    },
  );
}

void hideprogress(BuildContext context) {
  Navigator.pop(context);
}






// notification
class NotificationService {
  static Future<void> sendNotification(String targetToken, String title, String body) async {
    const String projectId = 'snapelite-2'; // Replace with your project ID

    Future<AutoRefreshingAuthClient> getAuthClient() async {
      final serviceAccountJson = await rootBundle.loadString('assets/serviceAccountKey.json');
      final credentials = ServiceAccountCredentials.fromJson(serviceAccountJson);

      final authClient = await clientViaServiceAccount(
        credentials,
        ['https://www.googleapis.com/auth/firebase.messaging'],
      );
      return authClient;
    }

    final authClient = await getAuthClient();

    const url = 'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    final message = {
      'message': {
        'token': targetToken,
        'notification': {
          'title': title,
          'body': body,
        },
      },
    };

    final response = await authClient.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully.');
    } else {
      print('Failed to send notification: ${response.body}');
    }

    authClient.close();
  }
}
