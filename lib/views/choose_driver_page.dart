import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:uber_josh/common/color_manager.dart';
import 'package:uber_josh/common/text_content.dart';
import 'dart:async';
// import 'package:uber_josh/views/arrived_page.dart';
import 'package:uber_josh/views/driver_arrived_page.dart';

class ChooseDriverPage extends StatefulWidget {
  final String currentAddress;
  final String destinationAddress;
  final String estimatedDollar;
  final String estimatedTime;
  final List<Map<String, dynamic>> stopPoints;
  final google_maps.LatLng currentPosition;

  ChooseDriverPage({
    required this.currentAddress,
    required this.destinationAddress,
    required this.estimatedDollar,
    required this.estimatedTime,
    required this.stopPoints,
    required this.currentPosition,
  });

  @override
  _ChooseDriverPageState createState() => _ChooseDriverPageState();
}

class _ChooseDriverPageState extends State<ChooseDriverPage> {
  bool _isDetail = false;
  String currentbasicName = "";
  String currentaddress = "";
  String tobasicName = "";
  String toaddress = "";

  @override
  void initState() {
    super.initState();
    _splitAddress(widget.currentAddress, true);
    _splitAddress(widget.destinationAddress, false);

    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DriverArrivedPage()),
      );
    });
  }

  void _onPressedDetailIcon() {
    setState(() {
      _isDetail = !_isDetail;
    });
  }

  void _splitAddress(String fullAddress, bool isCurrent) {
    List<String> parts = fullAddress.split(',');
    if (parts.length > 1) {
      setState(() {
        if (isCurrent) {
          currentbasicName = parts[0];
          currentaddress = parts.sublist(1).join(',').trim();
        } else {
          tobasicName = parts[0];
          toaddress = parts.sublist(1).join(',').trim();
        }
      });
    } else {
      setState(() {
        if (isCurrent) {
          currentbasicName = fullAddress;
          currentaddress = '';
        } else {
          tobasicName = fullAddress;
          toaddress = '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          google_maps.GoogleMap(
            initialCameraPosition: google_maps.CameraPosition(
              target: widget.currentPosition,
              zoom: 18,
            ),
          ),
          if (_isDetail)
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
          Container(
            color: Colors.white.withOpacity(0.5), // Background for AppBar
            child: AppBar(
              backgroundColor: Colors.transparent, // Make AppBar transparent
              elevation: 0, // Remove AppBar shadow
              leading: IconButton(
                icon: Image.asset(Apptext.backIcon_image),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              automaticallyImplyLeading: false,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/driver_image.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'George Einstein',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(' . ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('5.0',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.star, color: Colors.amber, size: 16),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Driver is on the way - 0.8km ',
                                  style: TextStyle(color: Colors.grey)),
                              Text(
                                "(${widget.estimatedTime})",
                                style: TextStyle(
                                    color: ColorManager
                                        .button_login_background_color,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: _onPressedDetailIcon,
                        child: Icon(
                            _isDetail
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: ColorManager.button_call_color,
                            size: 35),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Audi TT - Silver'),
                            Text(
                              '506 MKK',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ],
                        ),
                        Spacer(),
                        Image.asset('assets/images/car_image1.png', width: 100),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0), // Add padding for spacing
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Wrap content
                            children: [
                              Text(
                                'Text your driver',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 8), // Space between text and icon
                              Icon(
                                Icons.message,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorManager.button_login_background_color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0), // Add padding for spacing
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Wrap content
                            children: [
                              Text(
                                'Call',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 8), // Space between text and icon
                              Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_isDetail)
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                width: 30,
                                child: Column(
                                  children: [
                                    Image.asset(
                                        "assets/images/from_location_icon.png"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset('assets/images/line.png'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                        'assets/images/to_location_icon.png'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'From',
                                      style: TextStyle(
                                          color: ColorManager
                                              .button_login_background_color,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      currentbasicName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      currentaddress,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'To',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      tobasicName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      toaddress,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 1.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment Type',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.attach_money,
                                            color: ColorManager
                                                .button_login_background_color,
                                            size: 16),
                                        SizedBox(width: 4),
                                        Text('CASH',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Fare Total',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '\$ ${widget.estimatedDollar}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                  maxWidth: double.infinity, minHeight: 50),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
