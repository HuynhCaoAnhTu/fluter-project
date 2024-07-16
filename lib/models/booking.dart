import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String bookingId;
  final String uid;
  final String username;
  final DateTime checkIn;
  final DateTime checkOut;
  final int numRoom;
  final String phone;
  final String email;
  final String hotelName;
  final String hotelLocation;
  final String hotelPhoto;

  final String payment;
  final int price;

  const Booking({
    required this.bookingId,
    required this.uid,
    required this.username,
    required this.checkIn,
    required this.checkOut,
    required this.numRoom,
    required this.phone,
    required this.email,
    required this.hotelName,
    required this.hotelLocation,
    required this.hotelPhoto,
    required this.payment,
    required this.price,
  });

  // static Booking fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;

  //   return Booking(
  //       description: snapshot["description"],
  //       uid: snapshot["uid"],
  //       likes: snapshot["likes"],
  //       postId: snapshot["postId"],
  //       datePublished: snapshot["datePublished"],
  //       username: snapshot["username"],
  //       postUrl: snapshot['postUrl'],
  //       profImage: snapshot['profImage']);
  // }

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "uid": uid,
        "username": username,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "numRoom": numRoom,
        'phone': phone,
        'email': email,
        'hotelName': hotelName,
        'hotelLocation': hotelLocation,
        'hotelPhoto': hotelPhoto,
        'payment': payment,
        'price': price,
      };
}
