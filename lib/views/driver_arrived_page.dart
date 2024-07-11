import 'package:flutter/material.dart';
import 'dart:async';

import 'package:uber_josh/views/arrived_page.dart';

class DriverArrivedPage extends StatefulWidget {
  @override
  _DriverArrivedPageState createState() => _DriverArrivedPageState();
}

class _DriverArrivedPageState extends State<DriverArrivedPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ArrivedPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/arrived_image.png'), 
            Text(
              'Your driver has arrived!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
