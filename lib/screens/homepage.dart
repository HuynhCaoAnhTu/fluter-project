// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bolu_app/utils/colors.dart';
import 'package:bolu_app/widgets/tag.dart';
import 'package:bolu_app/widgets/hotel.dart';

class HomepageScreen extends StatefulWidget {
  final String uid;
  const HomepageScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();
  late String selectedTagId = '';
  List<DocumentSnapshot> hotelList = [];
  List<DocumentSnapshot> tagList = [];
  var userData = {};

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      // get post lENGT
    } catch (e) {
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getTagList();
    getAllHotelList();
    _textController.addListener(_onSearchChange);
    selectedTagId = 'FsWTrSJd7yMb9nyEubjt';
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _textController.dispose();
    _textController.removeListener(_onSearchChange);
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  Future<void> getAllHotelList() async {
    List<DocumentSnapshot> hotels = await getHotelListFromFirebase();
    setState(() {
      hotelList = hotels;
    });
  }

  Future<void> getHotelList(String tagId) async {
    if (tagId == 'FsWTrSJd7yMb9nyEubjt') {
      getAllHotelList();
    } else {
      List<DocumentSnapshot> hotels = await getHotelListByTagFirebase(tagId);
      setState(() {
        hotelList = hotels;
					print(hotelList);
      });
    }
  }

  Future<void> getTagList() async {
    List<DocumentSnapshot> tags = await getTagListFromFirebase();
    setState(() {
      tagList = tags;
    });
  }

  Future<List<DocumentSnapshot>> getTagListFromFirebase() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('tags').get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching category list: $e');
      return [];
    }
  }

  Future<List<DocumentSnapshot>> getHotelListFromFirebase() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('hotels').get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching category list: $e');
      return [];
    }
  }

  Future<List<DocumentSnapshot>> getHotelListByTagFirebase(String tagId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('hotels')
          .where('tagID', arrayContainsAny: [tagId])
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching product list: $e');
      return [];
    }
  }

  void _handleTagSelected(String tagId) {
    setState(() {
      selectedTagId = tagId;
      getHotelList(selectedTagId);
			print(selectedTagId);

    });
  }

  void _onSearchChange() {
    print(_textController.text);
    searchResultList();
  }

  searchResultList() {
    List<DocumentSnapshot> showResults = [];
    if (_textController.text == '') {
      getHotelList(selectedTagId);
    } else {
      for (var clientSnapShot in hotelList) {
        var name = clientSnapShot['hotelName'].toString().toLowerCase();
        var location = clientSnapShot['hotelLocation'].toString().toLowerCase();
        if (name.contains(_textController.text) ||
            location.contains(_textController.text)) {
          showResults.add(clientSnapShot);
        }
      }
      setState(() {
        hotelList = showResults;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: Text(
                              'Bolu',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Image.asset(
                              'assets/notification.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Image.asset(
                            'assets/bookmark.png',
                            width: 25,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Hello, ${userData['username']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Urbanist',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _textController,
                        focusNode: _textFieldFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Tìm kiếm',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            // Adjust label style as needed
                          ),
                          hintStyle: TextStyle(
                            color: Colors.black,
                            // Adjust hint style as needed
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search_sharp,
                            color: Colors.black, // Adjust color as needed
                          ),
                          suffixIcon: Icon(
                            Icons.filter_list,
                            color: Color(0xFF1AB65C),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          // Add validation logic if needed
                          return null;
                        },
                      ),
                    ),
                  ),

                  // LayoutBuilder(
                  //   builder: (BuildContext context, BoxConstraints constraints) {
                  //     // Your widget tree here
                  //     return TagList(
                  //       tagList: tagList,
                  //       ontagSelected: (String tagId) {
                  //         _handleTagSelected(tagId);
                  //       },
                  //       selectedtagId: selectedTagId,
                  //     );
                  //   },
                  // )

                  // Container(
                  //   width: 100,
                  // 	height: 100,
                  //   decoration: BoxDecoration(
                  //     color: primaryColor,
                  //   ),
                  //   child: TagList(
                  //         tagList: tagList,
                  //         ontagSelected: (String tagId) {
                  //           _handleTagSelected(tagId);
                  //         },
                  //         selectedtagId: selectedTagId,
                  //       ),
                  // ),
                  // 	Container(
                  //   width: 100,
                  // 	height: 100,
                  //   decoration: BoxDecoration(
                  //     color: primaryColor,
                  //   ),
                  //   child: HotelList(hotelList: hotelList)
                  // ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      height: 30,
                      child: TagList(
                        tagList: tagList,
                        ontagSelected: (String tagId) {
                          _handleTagSelected(tagId);
                        },
                        selectedtagId: selectedTagId,
                      ),
                    ),
                  ),

                  // Container(
                  //   height: 50,
                  //   child: HotelList(hotelList: hotelList),
                  // ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Container(
                        height: 403,
                        decoration: BoxDecoration(),
                        child: HotelList(hotelList: hotelList, uid: widget.uid,)),
                  ),
                ],
              ),
            ),
          )),
      resizeToAvoidBottomInset: false,
    );
  }
}
