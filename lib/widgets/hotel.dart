// ignore_for_file: prefer_const_constructors, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bolu_app/screens/hotel_detail.dart';

class HotelList extends StatelessWidget {
  final List<DocumentSnapshot> hotelList;
	final uid;
  HotelList({required this.hotelList , required this.uid});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: hotelList.length,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HotelDetailWidget(
                       uid: FirebaseAuth.instance.currentUser!.uid,
											 hotelId:  hotelList[index]['hotelId'],
                      ),
                    ),
                  ),
              child: Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFFE8F8EF),
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(
                  //   color: Colors.black,
                  // ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          hotelList[index]['hotelPhoto'],
                          width: 91,
                          height: 91,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                     width: MediaQuery.sizeOf(context).width*0.35,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotelList[index]['hotelName'],
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              softWrap: true, // Cho phép xuống dòng mềm dẻo
                              overflow: TextOverflow
                                  .ellipsis, // Hoặc bạn có thể sử dụng TextOverflow.fade
                              maxLines:
                                  3, // Đặt số dòng tối đa bạn muốn hiển thị
                            ),
                            Text(
                              hotelList[index]['hotelLocation'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'Urbanist', color: Colors.black),
                            ),
                            Text(
                              hotelList[index]['hotelReview'].toString(),
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                          alignment: AlignmentDirectional(1.00, 0.00),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {},
                                        child: Text(
                                          '${hotelList[index]['hotelsPrice'].toString()}',
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
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: 11,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: ClipRRect(
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
                // child: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(15),
                //       child: Image.network(
                //         hotelList[index]['hotelPhoto'],
                //         width: 91,
                //         height: 91,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.max,
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             hotelList[index]['hotelName'],
                //             style: TextStyle(
                //                 fontFamily: 'Urbanist',
                //                 fontSize: 17,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black),
                //           ),
                //           Text(
                //             hotelList[index]['hotelLocation'],
                //             textAlign: TextAlign.start,
                //             style: TextStyle(
                //                 fontFamily: 'Urbanist', color: Colors.black),
                //           ),
                //           Text(
                //             ' ${hotelList[index]['hotelsPrice'].toString()} review',
                //             style: TextStyle(
                //                 fontFamily: 'Urbanist',
                //                 fontSize: 13,
                //                 fontStyle: FontStyle.italic,
                //                 color: Colors.black),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                //         child: Flexible(
                //           child: Align(
                //             alignment: AlignmentDirectional(1.00, 0.00),
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Padding(
                //                   padding:
                //                       EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                //                   child: Column(
                //                     children: [
                //                       InkWell(
                //                         splashColor: Colors.transparent,
                //                         focusColor: Colors.transparent,
                //                         hoverColor: Colors.transparent,
                //                         highlightColor: Colors.transparent,
                //                         onTap: () async {},
                //                         child: Text(
                //                           '\$${hotelList[index]['hotelsPrice'].toString()}',
                //                           style: TextStyle(
                //                             fontFamily: 'Urbanist',
                //                             color: Color(0xFF1AB65C),
                //                             fontSize: 20,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                         ),
                //                       ),
                //                       Text(
                //                         ' /night',
                //                         style: TextStyle(
                //                             fontFamily: 'Urbanist',
                //                             fontSize: 11,
                //                             color: Colors.black),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding:
                //                       EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                //                   child: ClipRRect(
                //                     borderRadius: BorderRadius.circular(8),
                //                     child: Image.asset(
                //                       'assets/bookmark.png',
                //                       width: 25,
                //                       height: 25,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )),
                //   ],
                // ),
              ));
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8); // Adjust the width of the divider
        });
  }
}
