import 'package:flutter/material.dart';
import 'package:flutter_training/sources/session_source.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    await Future.delayed(Duration(seconds: 1));
    final token = await SessionSource().readToken();
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/profil');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          "http://bkd.blitarkota.go.id/sikoi/image_icon/sikoi.png",
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
