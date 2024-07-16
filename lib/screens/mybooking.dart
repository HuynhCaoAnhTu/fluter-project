import 'package:bolu_app/resources/auth_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookingWidget extends StatefulWidget {
  const BookingWidget({Key? key}) : super(key: key);

  @override
  _BookingWidgetState createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var bookingList = [];
  @override
  void initState() {
    super.initState();
    getBookingList();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getBookingList() async {
    List<DocumentSnapshot> bookings = await getBookingListByUserFirebase(
      FirebaseAuth.instance.currentUser!.uid,
    );
    setState(() {
      bookingList = bookings;
      print( bookingList[0]['hotelPhoto']);

    });
  }

  Future<List<DocumentSnapshot>> getBookingListByUserFirebase(
      String uid) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('booking')
          .where('uid', isEqualTo: uid)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching product list: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 29, 15, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(14, 10, 0, 10),
                        child: Text(
                          'My Booking',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 24,
														color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE8F8EF),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 21, 20, 0),
                  child: ListView.builder(
                      // padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: bookingList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 21, 10, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                             bookingList[index]['hotelPhoto'],
                                              width: 91,
                                              height: 91,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    14, 0, 0, 0),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        bookingList[index]['hotelName'],
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
																															color: Colors.black
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(  bookingList[index]['hotelLocation'],
                                                          style: TextStyle(color: Colors.black)),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFDBF8E6),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(22,
                                                                      3, 22, 3),
                                                          child: Text(
                                                            'Paid',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Urbanist',
                                                              color: Color(
                                                                  0xFF1AB65C),
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 21),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.8,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF7D7D7D),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25, 0, 25, 11),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 125,
                                              height: 31,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(16),
                                                  bottomRight:
                                                      Radius.circular(16),
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                border: Border.all(
                                                  color: Color(0xFF1AB65C),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(9, 5, 9, 5),
                                                child: Text(
                                                  'Cancel Booking',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Readex Pro',
                                                    color: Color(0xFF1AB65C),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 125,
                                              height: 31,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF1AB65C),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(16),
                                                  bottomRight:
                                                      Radius.circular(16),
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                border: Border.all(
                                                  color: Color(0xFF1AB65C),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(9, 5, 9, 5),
                                                child: Text(
                                                  'View Ticket',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
									),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
