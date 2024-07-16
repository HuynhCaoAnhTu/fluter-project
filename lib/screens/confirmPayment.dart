import 'package:bolu_app/resources/firestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfirmPaymentWidget extends StatefulWidget {
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
      numDay,
      payment;
  const ConfirmPaymentWidget(
      {Key? key,
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
      required this.payment})
      : super(key: key);

  @override
  _ConfirmPaymentWidgetState createState() => _ConfirmPaymentWidgetState();
}

class _ConfirmPaymentWidgetState extends State<ConfirmPaymentWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late double tax;
  late double total;
  @override
  void initState() {
    getTax();
    getTotal();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void getTax() {
    setState(() {
      tax = widget.price * (10 / 100);
    });
  }

  void getTotal() {
    setState(() {
      total = tax + (widget.price);
    });
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
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F8EF),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE8F8EF),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 60, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE8F8EF),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10, 0,
                                                                    10, 0),
                                                        child: Container(
                                                          width: 100,
                                                          height: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .hotelPhoto,
                                                                    width: 91,
                                                                    height: 91,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.35,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        widget
                                                                            .hotelName,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        softWrap:
                                                                            true, // Cho phép xuống dòng mềm dẻo
                                                                        overflow:
                                                                            TextOverflow.ellipsis, // Hoặc bạn có thể sử dụng TextOverflow.fade
                                                                        maxLines:
                                                                            3, // Đặt số dòng tối đa bạn muốn hiển thị
                                                                      ),
                                                                      Text(
                                                                        widget
                                                                            .hotelLocation,
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Urbanist',
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.00,
                                                                            0.00),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              20,
                                                                              0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {},
                                                                                  child: Text(
                                                                                    widget.price.toString(),
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Urbanist',
                                                                                      color: Color(0xFF1AB65C),
                                                                                      fontSize: 20,
                                                                                      fontWeight: FontWeight.w700,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  ' /night',
                                                                                  style: TextStyle(fontFamily: 'Urbanist', fontSize: 11, color: Colors.black),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                15,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              child: Image.asset(
                                                                                'assets/bookmark.png',
                                                                                width: 25,
                                                                                height: 25,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ),
                                                            ],
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 15, 30),
                              child: Container(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Check in',
                                              style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                color: Color(0xFF515151),
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              'Check out',
                                              style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                color: Color(0xFF515151),
                                                fontSize: 17,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Room',
                                              style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                color: Color(0xFF515151),
                                                fontSize: 17,
                                              ),
                                            ),
                                          ]),
                                      Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(widget.checkin!),
                                              style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(widget.checkout!),
                                              style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              widget.numRoom.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 15, 30),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 20, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${widget.numDay} Night',
                                                style: TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  color: Color(0xFF515151),
                                                  fontSize: 17,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Taxes & Fees (10%)',
                                                style: TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  color: Color(0xFF515151),
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '\$${widget.price}',
                                                style: TextStyle(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '\$${tax.toString()}',
                                                style: TextStyle(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.8,
                                      height: 1,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFC4C4C4),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 20, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              color: Color(0xFF515151),
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            '\$${total.toString()}',
                                            style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                              FireStoreMethods().bookingHotel(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  widget.name,
                                  widget.checkin,
                                  widget.checkout,
                                  widget.numRoom,
                                  widget.phone,
                                  widget.email,
                                  widget.hotelName,
                                  widget.hotelLocation,
                                  widget.hotelPhoto,
                                  widget.payment,
                                  widget.price);
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
                              'Done',
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
