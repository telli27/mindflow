import 'package:mindflow/config/appConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../model/usermodel.dart';
import '../../provider/themeCtx.dart';
import '../../services/auth.dart';
import '../profile/UpdateProfile.dart';
import '../registerandlogin/loginandRegister.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String currentLanguage = "";
  String currentThemeName = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getLanguage() async {}

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    final themeCtx = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Ayarlar",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      decorationThickness: 1.2,
                     
                      
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 0),
        child: Column(
          children: [
            Container(
              height: 150,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Profil Ayarları",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<DocumentSnapshot>(
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return UpdateProfile(userModel: userModel);
                              })));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        child: userModel.image == null
                                            ? CircleAvatar(
                                                maxRadius: 27,
                                                child: Icon(Icons
                                                    .supervised_user_circle_outlined),
                                              )
                                            : userModel.image!.isNotEmpty
                                                ? CircleAvatar(
                                                    maxRadius: 27,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            userModel.image!))
                                                : Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.orange)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Center(
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .userAstronaut,
                                                          color: Colors.black,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      userModel.seeName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: HexColor("#ABB4C7"))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: FaIcon(FontAwesomeIcons.arrowRight,
                                          size: 16, color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            maxRadius: 25,
                            child: Icon(Icons.supervised_user_circle_outlined),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Container(
              height: 280,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Uygulama Ayarları",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.pencil,
                                    color: Colors.black, size: 20),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                Text(
                                  "Tema",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: CupertinoSwitch(
                                value: themeCtx.theme,
                                onChanged: (value) {
                                  setState(() {});
                                  themeCtx.changeTheme(th: value);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: HexColor("#ECF0F8"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (() async {}),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FaIcon(FontAwesomeIcons.language,
                                      size: 20, color: Colors.black),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  Text(
                                    "Uygulama Dili",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1, color: HexColor("#ABB4C7"))),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(FontAwesomeIcons.arrowRight,
                                      size: 16, color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 1,
                        color: HexColor("#ECF0F8"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          _authServices.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return LoginAndRegister();
                          })));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.close,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                    "Çıkış Yap",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1, color: HexColor("#ABB4C7"))),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(FontAwesomeIcons.arrowRight,
                                      size: 16, color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
