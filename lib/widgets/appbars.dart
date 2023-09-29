import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/appConfig.dart';
import '../model/usermodel.dart';
import '../views/profile/ProfilePage.dart';

class CustomAppBarOneButtonWhite extends StatefulWidget {
  BuildContext context;
  String title;
  IconData icons;

  CustomAppBarOneButtonWhite(
      {Key? key,
      required this.context,
      required this.title,
      required this.icons})
      : super(key: key);

  @override
  State<CustomAppBarOneButtonWhite> createState() =>
      _CustomAppBarOneButtonWhiteState();
}

class _CustomAppBarOneButtonWhiteState
    extends State<CustomAppBarOneButtonWhite> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                /*   Navigator.push(context,
                                 MaterialPageRoute(builder: ((context) {
                               return NotificationPage();
                             })));*/
              },
              child: FaIcon(FontAwesomeIcons.bell,
                  size: 24,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppConfig.appColor),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("InkWell", style: Theme.of(context).textTheme.headline5),
                Text(
                  "New article",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection("User")
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> veri) {
                  if (veri.hasData) {
                    UserModel userModel = UserModel.fromMap(
                        veri.data!.data() as Map<String, dynamic>);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) =>
                                    ProfilePage(userModel: userModel)));
                      },
                      child: Container(
                          child: userModel.image!.isNotEmpty
                              ? CircleAvatar(
                                  maxRadius: 25,
                                  backgroundImage:
                                      NetworkImage(userModel.image!),
                                )
                              : Icon(Icons.supervised_user_circle_outlined,
                                  size: 50, color: Colors.black)),
                    );
                  } else {
                    return CircleAvatar(
                      maxRadius: 30,
                      child: Icon(Icons.supervised_user_circle_outlined),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
