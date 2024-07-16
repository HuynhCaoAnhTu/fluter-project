import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bolu_app/models/user.dart';
import 'package:bolu_app/providers/user_provider.dart';
import 'package:bolu_app/screens/payment.dart';
import 'package:provider/provider.dart';

class UserInforWidget extends StatefulWidget {
  final checkin, checkout, numRoom, price, hotelName, hotelLocation , hotelPhoto,numDay;
  const UserInforWidget(
      {Key? key,
      required this.checkin,
      required this.checkout,
      required this.numRoom,
      required this.price,
      required this.hotelName,
      required this.hotelLocation,
			  required this.hotelPhoto,
			required this.numDay})
      : super(key: key);

  @override
  _UserInforWidgetState createState() => _UserInforWidgetState();
}

class _UserInforWidgetState extends State<UserInforWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    final TextEditingController _usernameController =
        TextEditingController(text: '${user.username}');
    final TextEditingController _emailController =
        TextEditingController(text: '${user.email}');
    final TextEditingController _phoneController = TextEditingController();
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
                            'Name of Reservation',
                            style: GoogleFonts.urbanist(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F8EF),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE0E3E7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0x00FFFFFF),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _usernameController,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              // enabledBorder:
                                              //     UnderlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //     color: Colors.black,
                                              //     width: 0,
                                              //   ),
                                              //   borderRadius:
                                              //       BorderRadius.circular(8),
                                              // ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                            // Add your validation logic here
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE0E3E7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0x00FFFFFF),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _phoneController,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Phone',
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              // enabledBorder:
                                              //     UnderlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //     color: Colors.black,
                                              //     width: 0,
                                              //   ),
                                              //   borderRadius:
                                              //       BorderRadius.circular(8),
                                              // ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                            // Add your validation logic here
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE0E3E7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0x00FFFFFF),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _emailController,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              // enabledBorder:
                                              //     UnderlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //     color: Colors.black,
                                              //     width: 0,
                                              //   ),
                                              //   borderRadius:
                                              //       BorderRadius.circular(8),
                                              // ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                            // Add your validation logic here
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Repeat the above pattern for the other TextFormField widgets
                            ],
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentWidget(
                                  checkin: widget.checkin,
                                  checkout: widget.checkout,
                                  numRoom: widget.numRoom,
                                  name: _usernameController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                  price: widget.price,
                                  hotelName: widget.hotelName,
                                  hotelLocation: widget.hotelLocation,
																	hotelPhoto: widget.hotelPhoto,
																	numDay: widget.numDay,
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
                              'Continue',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
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
