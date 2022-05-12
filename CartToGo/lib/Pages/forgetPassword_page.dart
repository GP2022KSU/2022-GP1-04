import 'package:carttogo/Pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carttogo/main.dart';
import 'package:flutter/material.dart';
import 'package:carttogo/utils.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                          image: AssetImage('assets/images/blueCart.png')),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: "البريد الالكتروني",
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                hintText: "أدخل بريدك الالكتروني",
                                hintStyle: TextStyle(fontSize: 18),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide:
                                        BorderSide(width: 2, color: appColor)),
                                suffixIcon: Icon(Icons.email_outlined,
                                    color: appColor)),
                            validator: (value) {
                              if (value!.length == 0) {
                                return 'الرجاء ادخال البريد الالكتروني';
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("أدخل بريد الكتروني صحيح");
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {}),
                      ),
                      const SizedBox(height: 40.0),
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(8.0),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 20, fontFamily: 'CartToGo')),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(270, 50)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              backgroundColor:
                                  MaterialStateProperty.all(appColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            );


                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: _emailController.text);
                                      
                              Utils.showSnackBar(
                                  'تم ارسال بريد الكتروني لإعادة تعيين كلمة المرور');
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            } on FirebaseAuthException catch (e) {
                              print(e);
                              Utils.showSnackBar(e.message);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('إعادة تعيين كلمة المرور')),
                      const SizedBox(height: 15.0),
                      ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8.0),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 25, fontFamily: 'CartToGo')),
                  fixedSize: MaterialStateProperty.all(const Size(270, 45)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  backgroundColor: MaterialStateProperty.all(appColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WelcomePage();
                }));
              },
              child: const Text('عودة')),
                    ]),
              )),
        ));
  }
}

// void _showMyDialog(String success) async {
//   return showDialog<void>(
//       context: context,
//       // user must tap button!
//       builder: (BuildContext context) {
//         return Directionality(
//             textDirection: TextDirection.rtl,
//             child: Dialog(
//               elevation: 0,
//               backgroundColor: Color(0xffffffff),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(height: 15),
//                   Text(
//                     success, //Product name for IOS 1 android 4
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Divider(
//                     height: 2,
//                     color: Colors.black,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 50,
//                     child: InkWell(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(15.0),
//                         bottomRight: Radius.circular(15.0),
//                       ),
//                       highlightColor: Colors.grey[200],
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Center(
//                         child: Text(
//                           "موافق",
//                           style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               color: appColor),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//       });
// }
