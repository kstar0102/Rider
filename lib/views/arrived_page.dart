import 'package:flutter/material.dart';
import 'package:uber_josh/common/color_manager.dart';
import 'package:uber_josh/views/rider_main_page.dart';

class ArrivedPage extends StatefulWidget {
  @override
  _ArrivedPageState createState() => _ArrivedPageState();
}

class _ArrivedPageState extends State<ArrivedPage> {
  int _selectedRating = 0;
  String _selectedTip = '';
  TextEditingController _reviewController = TextEditingController();
  bool _isLoading = false;

  void _onSubmitButtonPress() {
    if (_reviewController.text.isEmpty || _selectedTip == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Warning'),
          content: Text('Please leave a review and select a tip amount.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _isLoading = true; // Toggle loading state
      });
      Future.delayed(Duration(seconds: 4), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RiderMainPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(20),
    );

    final OutlineInputBorder enabledInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(20),
    );
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      ColorManager.button_mainuser_right_color,
                      ColorManager.button_mainuser_left_color,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Spacer(),
                        Text(
                          'How was your ride?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/driver_image.png'),
                      radius: 45,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'George Einstein',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0, -30),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: index < _selectedRating ? ColorManager.button_star_color : Colors.grey,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _reviewController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Leave a Review',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "The driver is so kind and honest:D ",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: focusedBorder,
                            enabledBorder: enabledInputBorder,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "Perfect!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "Add a trip to show your appreciation. Drivers receive 100% of it.",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 20.0,
                          runSpacing: 10.0,
                          children: [
                            _buildTipButton(context, '\$2'),
                            _buildTipButton(context, '\$5'),
                            _buildTipButton(context, '\$10'),
                            _buildTipButton(context, '\$15'),
                            _buildTipButton(context, '\$25'),
                            _buildTipButton(context, '\$50'),
                          ],
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            // Handle enter custom amount tap
                          },
                          child: Text(
                            'Enter the custom amount',
                            style: TextStyle(
                              color: ColorManager.button_login_background_color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _onSubmitButtonPress,
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorManager.button_mainuser_left_color,
                                  ColorManager.button_mainuser_right_color,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                maxWidth: double.infinity,
                                minHeight: 45,
                              ),
                              child: _isLoading
                                  ? Center(
                                      child: SizedBox(
                                        width: 24.0, // Custom width
                                        height: 24.0, // Custom height
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          strokeWidth: 3.0, // Optional: custom stroke width
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Image.asset('assets/images/all_arrived.png'),
                          SizedBox(height: 20),
                          Text(
                            'Rate Succeed!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'You will automatically direct back to the Homepage in a moment.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTipButton(BuildContext context, String amount) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedTip = amount;
        });
      },
      child: Text(
        amount,
        style: TextStyle(
          color: _selectedTip == amount ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedTip == amount ? ColorManager.button_login_background_color : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: Size(100, 40),
      ),
    );
  }
}
