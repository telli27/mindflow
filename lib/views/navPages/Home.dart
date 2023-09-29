import 'package:mindflow/views/navPages/Articles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../config/appConfig.dart';
import '../../model/usermodel.dart';
import '../../services/auth.dart';
import '../../widgets/appbars.dart';
import '../profile/ProfilePage.dart';
import '../registerandlogin/loginandRegister.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.white,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: InkWell(
                  onTap: () {},
                  child: FaIcon(FontAwesomeIcons.bell,
                      size: 24,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : AppConfig.appColor),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Mindflow',
                    style: GoogleFonts.courgette(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                    //greatVibes,courgette
                  ),
                  Text(
                    "Düşünce Akışında Bilgi Hazinesi",
                    style: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 15, left: 0),
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
                                  : Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2, color: Colors.orange)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.userAstronaut,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )));
                    } else {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.orange)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.userAstronaut,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  final List<QueryDocumentSnapshot<Object?>> categoriesGet =
                      snapshot.data!.docs;

                  return Container(
                    child: DefaultTabController(
                      length: categoriesGet.length,
                      child: Column(
                        children: [
                          Container(
                            child: TabBar(
                              tabs: categoriesGet.map((kategori) {
                                return Tab(
                                  text: kategori['title'],
                                );
                              }).toList(),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor:
                                  Color(0xff5f6368), //niceish grey
                              isScrollable: true,
                              labelStyle: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: categoriesGet.map((kategori) {
                                return TabBodyPage(
                                    categoryId: kategori["id"],
                                    title: kategori["title"]);
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
