import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bolu_app/screens/bookingInfor.dart';
import 'package:intl/intl.dart';

class SelectDayWidget extends StatefulWidget {
  final hotelsPrice, hotelName, hotelLocation, hotelPhoto;

  const SelectDayWidget(
      {Key? key,
      required this.hotelsPrice,
      required this.hotelName,
      required this.hotelLocation,
      required this.hotelPhoto})
      : super(key: key);

  @override
  _SelectDayWidgetState createState() => _SelectDayWidgetState();
}

class _SelectDayWidgetState extends State<SelectDayWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _counter = 1;
  int _counterGuest = 1;
  int _price = 0;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int numberOfDays = 1;

  _calculateDateDifference() {
    if (checkInDate != null && checkOutDate != null) {
      Duration difference = checkOutDate!.difference(checkInDate!);
      setState(() {
        numberOfDays = difference.inDays;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _priceCounter();
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> _checkIn(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkInDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != checkInDate) {
      setState(() {
        checkInDate = picked;
      });
      _calculateDateDifference();
      _priceCounter();
    }
  }

  Future<void> _checkOut(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkOutDate ?? DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != checkOutDate) {
      setState(() {
        checkOutDate = picked;
      });
      _calculateDateDifference();
      _priceCounter();
      print(numberOfDays);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _priceCounter();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        _priceCounter();
      }
    });
  }

  void _priceCounter() {
    setState(() {
      _price = int.parse(widget.hotelsPrice) * _counter * numberOfDays;
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
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
                            'Booking Information',
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'Check in',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE3DEDE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: Text(
                                              '${checkInDate != null ? DateFormat('dd/MM/yyyy').format(checkInDate!) : 'Choose Day'}',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Handle the button press event
                                              _checkIn(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: (Size(33, 33)),
                                              primary: Color(0xFF1AB65C),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),

                                            child: Icon(
                                              Icons.calendar_month,
                                              color: Color(0xFFE3DEDE),
                                            ),
                                            // Replace with your icon
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                              child: Image.asset(
                                'assets/arrow.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 5, 0),
                                  child: Text(
                                    'Check out',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE3DEDE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 20, 0),
                                            child: Text(
                                              '${checkOutDate != null ? DateFormat('dd/MM/yyyy').format(checkOutDate!) : 'Choose Day'}',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _checkOut(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: (Size(33, 33)),
                                              primary: Color(0xFF1AB65C),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),

                                            child: Icon(
                                              Icons.calendar_month,
                                              color: Color(0xFFE3DEDE),
                                            ),
                                            // Replace with your icon
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 20),
                        child: Text(
                          'Number of rooms',
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF7A7474),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _decrementCounter();
                                  },
                                  icon: Icon(Icons.remove),
                                  color: Color(0xFF1AB65C),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      35, 0, 35, 0),
                                  child: Text(
                                    '${_counter}',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _incrementCounter();
                                  },
                                  icon: Icon(Icons.add),
                                  color: Color(0xFF1AB65C),
                                ),
                              ],
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                      child: Text(
                        'Total: ${_price} \$',
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserInforWidget(
                              checkin: checkInDate,
                              checkout: checkOutDate,
                              numRoom: numberOfDays,
                              price: _price,
                              hotelName: widget.hotelName,
                              hotelLocation: widget.hotelLocation,
															hotelPhoto: widget.hotelPhoto,
                              numDay: numberOfDays,
                            ),
                          ));
													print(widget.hotelPhoto);
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
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
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
