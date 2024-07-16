import 'package:bolu_app/screens/confirmPayment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bolu_app/resources/firestore_methods.dart';

class PaymentWidget extends StatefulWidget {
  final checkin,
      checkout,
      numRoom,
      name,
      phone,
      email,
      price,
      hotelName,
      hotelLocation,
			hotelPhoto,
      numDay;
  const PaymentWidget({
    Key? key,
    required this.checkin,
    required this.checkout,
    required this.numRoom,
    required this.name,
    required this.phone,
    required this.email,
    required this.price,
    required this.hotelName,
    required this.hotelLocation,
		    required this.hotelPhoto,
    required this.numDay,
  }) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedOption = '';
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.00, 0.00),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: Color(0xFF212121),
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Text(
                            'Payment',
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 30),
                        child: Text(
                          'Payment Methods',
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFE8F8EF),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        40, 0, 40, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 15, 15, 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 10, 0, 10),
                                                child: CheckboxListTile(
                                                  title: Text('PayPal',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  value: _selectedOption ==
                                                      'PayPal',
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value!) {
                                                        _selectedOption =
                                                            'PayPal';
                                                      } else {
                                                        _selectedOption = '';
                                                      }
                                                    });
                                                  },
                                                  activeColor: Color(
                                                      0xFF1AB65C), // Set the active color
                                                  checkColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ), // Set the check color
                                                  secondary: Image.asset(
                                                    'assets/Paypal.png', // Thay đổi URL hình ảnh theo đường dẫn của bạn
                                                    width: 70,
                                                    height: 70,
                                                  ),
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 15, 15, 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 10, 0, 10),
                                                child: CheckboxListTile(
                                                  title: Text('Google Pay',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  value: _selectedOption ==
                                                      'Google Pay',
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value!) {
                                                        _selectedOption =
                                                            'Google Pay';
                                                      } else {
                                                        _selectedOption = '';
                                                      }
                                                    });
                                                  },
                                                  activeColor: Color(
                                                      0xFF1AB65C), // Set the active color
                                                  checkColor: Colors
                                                      .white, // Set the check color
                                                  secondary: Image.asset(
                                                    'assets/Google.png', // Thay đổi URL hình ảnh theo đường dẫn của bạn
                                                    width: 70,
                                                    height: 70,
                                                  ),
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 15, 15, 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 10, 0, 10),
                                              child: CheckboxListTile(
                                                title: Text('Apple Pay',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Urbanist',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                value: _selectedOption ==
                                                    'Apple Pay',
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value!) {
                                                      _selectedOption =
                                                          'Apple Pay';
                                                    } else {
                                                      _selectedOption = '';
                                                    }
                                                  });
                                                },
                                                activeColor: Color(
                                                    0xFF1AB65C), // Set the active color
                                                checkColor: Colors
                                                    .white, // Set the check color

                                                secondary: Image.asset(
                                                  'assets/apple.png', // Thay đổi URL hình ảnh theo đường dẫn của bạn
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                checkboxShape:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                            'Lựa chọn của bạn: $_selectedOption'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                        alignment: AlignmentDirectional(0.00, 1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // FireStoreMethods().bookingHotel(
                              //     FirebaseAuth.instance.currentUser!.uid,
                              //     widget.name,
                              //     widget.checkin,
                              //     widget.checkout,
                              //     widget.numRoom,
                              //     widget.phone,
                              //     widget.email,
                              //     _selectedOption,
                              //     widget.price);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ConfirmPaymentWidget(
                                  checkin: widget.checkin,
                                  checkout: widget.checkout,
                                  numRoom: widget.numRoom,
                                  name: widget.hotelName,
                                  phone: widget.phone,
                                  email: widget.email,
                                  price: widget.price,
                                  hotelName: widget.hotelName,
                                  hotelLocation: widget.hotelLocation,
																	hotelPhoto: widget.hotelPhoto,
																	numDay: widget.numDay,
																	payment: _selectedOption,
                                ),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: (Size(buttonWidth, 48)),
                              primary: Color(0xFF1AB65C),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Continues',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
