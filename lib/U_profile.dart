import 'package:flutter/material.dart';
import 'package:login/user_complain.dart';

import 'config.dart';
import 'main.dart';

class u_profile extends StatefulWidget {
  const u_profile({super.key});

  @override
  State<u_profile> createState() => _u_profileState();
}

class _u_profileState extends State<u_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ApiHelper.getonuser(prefs.getString("id").toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot2) {
        if (snapshot2.hasData) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileField(
                    label: 'Name',
                    value: snapshot2.data['name'],
                    icon: Icons.edit,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const user_complain()));
                    },
                  ),
                  ProfileField(
                    label: 'Cnic',
                    value: snapshot2.data['cnic'] ?? "",
                    icon: Icons.edit,
                    onTap: () {},
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: const Text(
                        'Verify email',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ProfileField(
                    label: 'Mobile number',
                    value: snapshot2.data['number'],
                    icon: Icons.edit,
                    onTap: () {
                      // Implement edit functionality
                    },
                    child: const Text(
                      'Verified',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  ProfileField(
                    label: 'Age',
                    value: snapshot2.data['age'] ?? "",
                    icon: Icons.edit,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const user_complain()));
                    },
                  ),
                  ProfileField(
                    label: 'City',
                    value: snapshot2.data['address'],
                    icon: Icons.edit,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const user_complain()));
                    },
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  // const Text(
                  //   'Connected accounts',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 8),
                  // ConnectedAccount(
                  //   icon: Icons.facebook,
                  //   label: 'Facebook',
                  //   status: 'Connect',
                  //   onTap: () {
                  //     // Implement connect functionality
                  //   },
                  // ),
                ],
              ),
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
    ));
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  final Widget child;

  ProfileField(
      {required this.label,
      required this.value,
      required this.icon,
      required this.onTap,
      this.child = const SizedBox.shrink()});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 20),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // child,
            ],
          ),
          // IconButton(
          //   icon: Icon(icon, color: Colors.pink),
          //   onPressed: onTap,
          // ),
        ],
      ),
    );
  }
}

class ConnectedAccount extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final VoidCallback onTap;

  ConnectedAccount(
      {required this.icon,
      required this.label,
      required this.status,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      trailing: TextButton(
        onPressed: onTap,
        child: Text(
          status,
          style: TextStyle(
              color: status == 'Connected' ? Colors.green : Colors.pink),
        ),
      ),
    );
  }
}
