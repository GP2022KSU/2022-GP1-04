// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carttogo/Pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:carttogo/widgets/CartInstructions.dart';
import 'package:carttogo/widgets/ShoppingCartWidget.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShoppingCart extends StatefulWidget {
  Function callback;
  ShoppingCart(this.callback);
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late bool ConnectedToCart = true;
  late bool _isLoading1;
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _streamSubscription4;
  @override
  void initState() {
    _isLoading1 = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isLoading1 = false;
        });
      }
    });
    super.initState();
    _activateListeners();
  }

  bool _activateListeners() {
    if (FirebaseAuth.instance.currentUser != null) {
      _streamSubscription4 = _database
          .child(
              "Shopper/${FirebaseAuth.instance.currentUser?.uid}/Carts/ConnectedToCart")
          .onValue
          .listen((event) {
        final data = event.snapshot.value;

        setState(() {
          String Fornow = "false";
          Fornow = data.toString();
          if (Fornow.toLowerCase() == 'true') {
            ConnectedToCart = true;
          } else if (Fornow.toLowerCase() == 'false') {
            ConnectedToCart = false;
          }
        });
      });
      return ConnectedToCart;
    }
    return ConnectedToCart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white24,
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: Text(
            "?????? ????????????",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'CartToGo',
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 14,
                          fontFamily: 'CartToGo',
                          fontWeight: FontWeight.bold)),
                      fixedSize: MaterialStateProperty.all(const Size(70, 10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    _showMyDialog();
                  },
                  child: const Text('????????')),
            ),
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          heightFactor: 1.6,
          child: ConnectedToCart ? ShoppingCartWidget() : Instructions(),
        ));
  }

  Widget Instructions() {
    if (ConnectedToCart == false && _isLoading1 == false) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          //color: Colors.black,
          child: Stack(children: [
            Positioned(
              top: 40,
              left: 20,
              child: Material(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(-10.0, 10.0),
                        blurRadius: 20,
                        spreadRadius: 4,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 33,
              child: Card(
                elevation: 10,
                shadowColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color.fromARGB(255, 35, 61, 255),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage("assets/images/HandQR.png"),
                        ))),
              ),
            ),
            Positioned(
              top: 60,
              right: 190,
              child: Container(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "???????? ????????????",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          indent: MediaQuery.of(context).size.height * 0.001,
                          endIndent: MediaQuery.of(context).size.height * 0.07,
                          color: Color.fromARGB(125, 0, 0, 0),
                        ),
                        Text(
                          "?????? ?????????? ????????????",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Color.fromARGB(255, 42, 41, 41),
                          ),
                        ),
                        Text(
                          "???????????? ???? ??????",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Color.fromARGB(255, 42, 41, 41),
                          ),
                        ),
                        Text(
                          "  ?????????? ????????????",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Color.fromARGB(255, 42, 41, 41),
                          ),
                        ),
                        Text(
                          "  ?????????? ????????????",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Color.fromARGB(255, 42, 41, 41),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              ),
            ),
            Positioned(
                top: 250,
                left: 55,
                child: Center(
                    child: AnimatedButton(
                  child: Text(
                    '????????',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    widget.callback(1);
                  },
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.1,
                  //shadowDegree: ShadowDegree.light,
                  color: Color.fromARGB(255, 35, 61, 255),
                ))),
          ]));
    }
    return Center(
        child: SpinKitWave(
      color: Color.fromARGB(255, 248, 248, 249),
    ));
  }

  void _showMyDialog() async {
    return showDialog<void>(
        context: context,
        // user must tap button!
        builder: (BuildContext context) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Dialog(
                elevation: 0,
                backgroundColor: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      "???? ???????? ?????????? ??????????????",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: InkWell(
                        highlightColor: Colors.grey[200],
                        onTap: () async {
                          final _fb = FirebaseDatabase.instance;
                          final Carts = await _fb.ref().child(
                              "Shopper/${FirebaseAuth.instance.currentUser?.uid}/Carts");
                          await Carts.update({
                            'ConnectedToCart': false,
                          });
                          await FirebaseAuth.instance.signOut();
                          print(
                              "UID: ${FirebaseAuth.instance.currentUser?.uid}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        },
                        child: Center(
                          child: Text(
                            "????????",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFFFE4A49),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        highlightColor: Colors.grey[200],
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text(
                            "??????????",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  @override
  void deactivate() {
    _streamSubscription4.cancel();
    super.deactivate();
  }
}
