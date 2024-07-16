// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bolu_app/models/user.dart';
import 'package:bolu_app/providers/user_provider.dart';
import 'package:bolu_app/resources/firestore_methods.dart';
import 'package:bolu_app/screens/selectDay.dart';
import 'package:bolu_app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HotelDetailWidget extends StatefulWidget {
  final uid, hotelId;
  const HotelDetailWidget({Key? key, required this.uid, required this.hotelId})
      : super(key: key);

  @override
  _HotelDetailWidgetState createState() => _HotelDetailWidgetState();
}

class _HotelDetailWidgetState extends State<HotelDetailWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var userData = {};
  var hotelData = {};
  List<Map<String, dynamic>> allCommentsData = [];
  CarouselController _carouselController = CarouselController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    getAllComments();
    print(allCommentsData);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> getAllComments() async {
    try {
      // Tìm tất cả các tài liệu có trường "hotelId" bằng giá trị hotelId đã cho
      var hotelQuery = await FirebaseFirestore.instance
          .collection('hotels')
          .where('hotelId', isEqualTo: widget.hotelId)
          .get();

      // Lặp qua kết quả truy vấn khách sạn
      for (var hotelDoc in hotelQuery.docs) {
        // Lấy tất cả các tài liệu từ bộ sưu tập "comments" của khách sạn hiện tại
        var commentQuery = await FirebaseFirestore.instance
            .collection('hotels')
            .doc(hotelDoc.id)
            .collection('comments')
            .get();

        // Lặp qua tài liệu của bộ sưu tập "comments" và thêm chúng vào danh sách
        for (var commentDoc in commentQuery.docs) {
          setState(() {
            allCommentsData.add(commentDoc.data() as Map<String, dynamic>);
          });
        }
      }

      // In ra danh sách tất cả các dữ liệu từ các bộ sưu tập "comments"
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
    }
  }

  void postComment(String uid, String name, String profilePic) async {
    try {
      String res = await FireStoreMethods().postComment(
        widget.hotelId,
        textController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        if (context.mounted) showSnackBar(context, res);
      }
      setState(() {
        textController.text = "";
      });
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var hotelSnap = await FirebaseFirestore.instance
          .collection('hotels')
          .doc(widget.hotelId)
          .get();
      var commentSnap = FirebaseFirestore.instance
          .collection('hotels')
          .doc(widget.hotelId)
          .collection('comments')
          .get();

      setState(() {
        userData = userSnap.data()!;
        hotelData = hotelSnap.data()!;
      });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 150),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            '${hotelData['hotelPhoto']}',
                            width: MediaQuery.sizeOf(context).width,
                            height: 283,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                            alignment: AlignmentDirectional(-1.00, 0.00),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: Color(0xFF212121),
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              padding: EdgeInsets.all(
                                  0), // Đặt giá trị padding theo ý muốn
                              color: Colors
                                  .transparent, // Đặt màu nền của nút thành trong suốt
                              iconSize: 60, // Đặt kích thước của biểu tượng
                            )),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.80,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 10, 0, 0),
                                child: Text(
                                  ' ${hotelData['hotelName']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontSize: 31,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 15),
                          child: Text(
                            ' ${hotelData['hotelLocation']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Color(0xFFE7E7E7),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                                child: Text(
                                  'Gallery Photos',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.95,
                                decoration: BoxDecoration(),
                                child: Container(
                                  width: double.infinity,
                                  height: 180,
                                  child: CarouselSlider(
                                    items: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://picsum.photos/seed/375/600',
                                          width: 300,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://picsum.photos/seed/887/600',
                                          width: 300,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://picsum.photos/seed/486/600',
                                          width: 300,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://picsum.photos/seed/946/600',
                                          width: 300,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                    carouselController: _carouselController,
                                    options: CarouselOptions(
                                      initialPage: 1,
                                      viewportFraction: 0.5,
                                      disableCenter: true,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.25,
                                      enableInfiniteScroll: true,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'HotelDetails',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/room.png',
                                              width: 28,
                                              height: 28,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            '4 Bedrooms\n',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            // style: FlutterFlowTheme.of(context)
                                            //     .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/bath.png',
                                              width: 28,
                                              height: 28,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            '4 Bedrooms\n',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            // style: FlutterFlowTheme.of(context)
                                            //     .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/vector.png',
                                              width: 28,
                                              height: 28,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            '4 Bedrooms\n',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            // style: FlutterFlowTheme.of(context)
                                            //     .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Review',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    '( ${allCommentsData.length} reviews)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: 400,
                            ),
                            decoration: BoxDecoration(),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 15, 0),
                                      child: ListView.separated(
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: allCommentsData.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 100,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .white, // Màu nền của box
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(
                                                        0.5), // Màu của đổ bóng và độ trong suốt
                                                    spreadRadius:
                                                        2, // Kéo rộng đổ bóng
                                                    blurRadius:
                                                        5, // Độ mờ của đổ bóng
                                                    offset: Offset(0,
                                                        3), // Dịch chuyển của đổ bóng theo chiều ngang và chiều dọc
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        15,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child: Image
                                                                      .network(
                                                                    allCommentsData[
                                                                            index]
                                                                        [
                                                                        'profilePic'],
                                                                    width: 50,
                                                                    height: 50,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Column(
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
                                                                      allCommentsData[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    Text(
                                                                      DateFormat
                                                                              .yMMMd()
                                                                          .format(
                                                                              allCommentsData[index]['datePublished'].toDate()),
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      15),
                                                          child: Container(
                                                            width: MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Text(
                                                                    allCommentsData[
                                                                            index]
                                                                        [
                                                                        'text'],
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Urbanist',
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
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
                                            );
                                          },
                                          // children: [
                                          //   Container(
                                          //     width: 100,
                                          //     height: 120,
                                          //     decoration: BoxDecoration(
                                          //       // color:
                                          //       //     FlutterFlowTheme.of(context)
                                          //       //         .secondaryBackground,
                                          //       borderRadius:
                                          //           BorderRadius.circular(12),
                                          //     ),
                                          //     child: Row(
                                          //       mainAxisSize: MainAxisSize.max,
                                          //       children: [
                                          //         Expanded(
                                          //           child: Column(
                                          //             mainAxisSize:
                                          //                 MainAxisSize.max,
                                          //             crossAxisAlignment:
                                          //                 CrossAxisAlignment.start,
                                          //             children: [
                                          //               Expanded(
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       EdgeInsetsDirectional
                                          //                           .fromSTEB(10,
                                          //                               15, 0, 0),
                                          //                   child: Row(
                                          //                     mainAxisSize:
                                          //                         MainAxisSize.max,
                                          //                     mainAxisAlignment:
                                          //                         MainAxisAlignment
                                          //                             .start,
                                          //                     children: [
                                          //                       ClipRRect(
                                          //                         borderRadius:
                                          //                             BorderRadius
                                          //                                 .circular(
                                          //                                     50),
                                          //                         child:
                                          //                             Image.network(
                                          //                           'https://picsum.photos/seed/358/600',
                                          //                           width: 50,
                                          //                           height: 50,
                                          //                           fit: BoxFit
                                          //                               .cover,
                                          //                         ),
                                          //                       ),
                                          //                       Column(
                                          //                         mainAxisSize:
                                          //                             MainAxisSize
                                          //                                 .max,
                                          //                         mainAxisAlignment:
                                          //                             MainAxisAlignment
                                          //                                 .spaceEvenly,
                                          //                         crossAxisAlignment:
                                          //                             CrossAxisAlignment
                                          //                                 .start,
                                          //                         children: [
                                          //                           Text(
                                          //                             'Hello World',
                                          //                             style: TextStyle(
                                          //                                 fontFamily:
                                          //                                     'Urbanist',
                                          //                                 fontSize:
                                          //                                     17,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 color: Colors
                                          //                                     .black),
                                          //                           ),
                                          //                           Text(
                                          //                             'Hello World',
                                          //                             style: TextStyle(
                                          //                                 fontFamily:
                                          //                                     'Urbanist',
                                          //                                 fontSize:
                                          //                                     15,
                                          //                                 color: Colors
                                          //                                     .black),
                                          //                           ),
                                          //                         ],
                                          //                       ),
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Padding(
                                          //                 padding:
                                          //                     EdgeInsetsDirectional
                                          //                         .fromSTEB(10, 10,
                                          //                             10, 15),
                                          //                 child: Container(
                                          //                   width:
                                          //                       MediaQuery.sizeOf(
                                          //                               context)
                                          //                           .width,
                                          //                   decoration:
                                          //                       BoxDecoration(),
                                          //                   child: Row(
                                          //                     mainAxisSize:
                                          //                         MainAxisSize.max,
                                          //                     children: [
                                          //                       Container(
                                          //                         decoration:
                                          //                             BoxDecoration(),
                                          //                         child: Text(
                                          //                           'Hello World',
                                          //                           style: TextStyle(
                                          //                               fontFamily:
                                          //                                   'Urbanist',
                                          //                               fontSize:
                                          //                                   14,
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .bold,
                                          //                               color: Colors
                                          //                                   .black),
                                          //                         ),
                                          //                       ),
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          //   Container(
                                          //     width: 100,
                                          //     height: 120,
                                          //     decoration: BoxDecoration(
                                          //       color:
                                          //           Colors.white, // Màu nền của box
                                          //       boxShadow: [
                                          //         BoxShadow(
                                          //           color: Colors.grey.withOpacity(
                                          //               0.5), // Màu của đổ bóng và độ trong suốt
                                          //           spreadRadius:
                                          //               2, // Kéo rộng đổ bóng
                                          //           blurRadius:
                                          //               5, // Độ mờ của đổ bóng
                                          //           offset: Offset(0,
                                          //               3), // Dịch chuyển của đổ bóng theo chiều ngang và chiều dọc
                                          //         ),
                                          //       ],
                                          //       borderRadius:
                                          //           BorderRadius.circular(12),
                                          //     ),
                                          //     child: Row(
                                          //       mainAxisSize: MainAxisSize.max,
                                          //       children: [
                                          //         Expanded(
                                          //           child: Column(
                                          //             mainAxisSize:
                                          //                 MainAxisSize.max,
                                          //             crossAxisAlignment:
                                          //                 CrossAxisAlignment.start,
                                          //             children: [
                                          //               Expanded(
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       EdgeInsetsDirectional
                                          //                           .fromSTEB(10,
                                          //                               15, 0, 0),
                                          //                   child: Row(
                                          //                     mainAxisSize:
                                          //                         MainAxisSize.max,
                                          //                     mainAxisAlignment:
                                          //                         MainAxisAlignment
                                          //                             .start,
                                          //                     children: [
                                          //                       ClipRRect(
                                          //                         borderRadius:
                                          //                             BorderRadius
                                          //                                 .circular(
                                          //                                     50),
                                          //                         child:
                                          //                             Image.network(
                                          //                           'https://picsum.photos/seed/358/600',
                                          //                           width: 50,
                                          //                           height: 50,
                                          //                           fit: BoxFit
                                          //                               .cover,
                                          //                         ),
                                          //                       ),
                                          //                       Column(
                                          //                         mainAxisSize:
                                          //                             MainAxisSize
                                          //                                 .max,
                                          //                         mainAxisAlignment:
                                          //                             MainAxisAlignment
                                          //                                 .spaceEvenly,
                                          //                         crossAxisAlignment:
                                          //                             CrossAxisAlignment
                                          //                                 .start,
                                          //                         children: [
                                          //                           Text(
                                          //                             'Hello World',
                                          //                             style: TextStyle(
                                          //                                 fontFamily:
                                          //                                     'Urbanist',
                                          //                                 fontSize:
                                          //                                     17,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w600,
                                          //                                 color: Colors
                                          //                                     .black),
                                          //                           ),
                                          //                           Text(
                                          //                             'Hello World',
                                          //                             style: TextStyle(
                                          //                                 fontFamily:
                                          //                                     'Urbanist',
                                          //                                 fontSize:
                                          //                                     15,
                                          //                                 color: Colors
                                          //                                     .black),
                                          //                           ),
                                          //                         ],
                                          //                       ),
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Padding(
                                          //                 padding:
                                          //                     EdgeInsetsDirectional
                                          //                         .fromSTEB(10, 10,
                                          //                             10, 15),
                                          //                 child: Container(
                                          //                   width:
                                          //                       MediaQuery.sizeOf(
                                          //                               context)
                                          //                           .width,
                                          //                   decoration:
                                          //                       BoxDecoration(),
                                          //                   child: Row(
                                          //                     mainAxisSize:
                                          //                         MainAxisSize.max,
                                          //                     children: [
                                          //                       Container(
                                          //                         decoration:
                                          //                             BoxDecoration(),
                                          //                         child: Text(
                                          //                           'sadjkdf',
                                          //                           style: TextStyle(
                                          //                               fontFamily:
                                          //                                   'Urbanist',
                                          //                               fontSize:
                                          //                                   14,
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .bold,
                                          //                               color: Colors
                                          //                                   .black),
                                          //                         ),
                                          //                       ),
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ],
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                                height:
                                                    8); // Adjust the width of the divider
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    user.photoUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: TextFormField(
                                      controller: textController,
                                      autofocus: false,
                                      obscureText: false,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Urbanist',
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Your comment',
                                        alignLabelWithHint: false,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF1AB65C),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    postComment(
                                      user.uid,
                                      user.username,
                                      user.photoUrl,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Color(0xFF1AB65C), // Màu nền của nút
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            10), // Khoảng cách giữa nút và nội dung
                                  ),
                                  child: Text(
                                    'Comment',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.00, 1.00),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE7E7E7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${hotelData['hotelsPrice']}',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Color(0xFF1AB65C),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' /night',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SelectDayWidget(
                                hotelsPrice: '${hotelData['hotelsPrice']}', hotelName:  '${hotelData['hotelName']}' , hotelLocation:  '${hotelData['hotelLocation']}' , hotelPhoto: '${hotelData['hotelPhoto']}' ),

                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1AB65C), // Màu nền của nút
                          elevation: 3, // Độ nâng của nút
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  50), // Khoảng cách giữa nút và nội dung
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                26.5), // Độ cong của mép nút
                          ),
                        ),
                        child: Text(
                          'Book now!',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      )
                    ],
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
