import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:bolu_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/booking.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> bookingHotel(
    String uid,
    String username,
    DateTime checkIn,
    DateTime checkOut,
    int numRoom,
    String phone,
    String email,
    String hotelName,
    String hotelLocation,
    String hotelPhoto,
    String payment,
    int price,
  ) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String bookingId = const Uuid().v1(); // creates unique id based on time
      Booking booking = Booking(
        bookingId: bookingId,
        uid: uid,
        username: username,
        checkIn: checkIn,
        checkOut: checkOut,
        numRoom: numRoom,
        phone: phone,
        email: email,
        hotelName: hotelName,
        hotelLocation: hotelLocation,
        hotelPhoto: hotelPhoto,
        payment: payment,
        price: price,
      );
      _firestore.collection('booking').doc(bookingId).set(booking.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String hotelId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('hotels')
            .doc(hotelId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
}
