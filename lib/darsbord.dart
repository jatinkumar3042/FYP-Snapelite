import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class dasboard extends StatefulWidget {
  final token;
  const dasboard({@required this.token, Key? key}) : super(key: key);

  @override
  State<dasboard> createState() => _dasboardState();
}

class _dasboardState extends State<dasboard> {
  late String number;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    number = jwtDecodedToken['number'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              number,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
