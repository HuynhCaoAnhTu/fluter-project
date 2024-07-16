import 'package:bolu_app/models/booking.dart';
import 'package:bolu_app/screens/confirmPayment.dart';
import 'package:bolu_app/screens/mybooking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bolu_app/main.dart';
// import 'package:bolu_app/screens/add_post_screen.dart';
import 'package:bolu_app/screens/feed_screen.dart';
import 'package:bolu_app/screens/homepage.dart';
import 'package:bolu_app/screens/hotel_detail.dart';
import 'package:bolu_app/screens/profile_screen.dart';
import 'package:bolu_app/screens/search_screen.dart';
import 'package:bolu_app/screens/selectDay.dart';
import 'package:bolu_app/screens/test.dart';
import 'package:bolu_app/screens/test1.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  HomepageScreen(uid: FirebaseAuth.instance.currentUser!.uid),
	 const BookingWidget(),
	// const HotelDetailWidget(),
  // const FeedScreen(),
  // const SearchScreen(),
	//  MyHomePage(),
	//  MyWidget(),

];
