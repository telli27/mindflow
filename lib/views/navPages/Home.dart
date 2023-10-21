import 'package:mindflow/provider/articleCtx.dart';
import 'package:mindflow/views/navPages/Articles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:ticker_text/ticker_text.dart';

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
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);

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
          articleCtx.message.toString().isEmpty || articleCtx.message == ""
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width, // constrain the parent width so the child overflows and scrolling takes effect
                    child: TickerText(
                      // default values

                      scrollDirection: Axis.horizontal,
                      speed: 25,
                      startPauseDuration: const Duration(seconds: 2),
                      endPauseDuration: const Duration(seconds: 5),
                      returnDuration: const Duration(seconds: 2),
                      primaryCurve: Curves.linear,
                      returnCurve: Curves.easeOut,
                      child: Text(
                        articleCtx.message.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  final List<QueryDocumentSnapshot<Object?>> categoriesGet =
                      snapshot.data!.docs;

                  // "home" kategorisini categoriesGet listesinin en başına ekleyin
                  categoriesGet.sort((a, b) {
                    if (a['id'] == 99) {
                      return -1; // "home" kategorisi önce gösterilsin
                    } else if (b['id'] == 99) {
                      return 1;
                    }
                    return a['id'].compareTo(b['id']);
                  });

                  return Container(
                    child: DefaultTabController(
                      length: categoriesGet.length,
                      child: Column(
                        children: [
                          Container(
                            child: TabBar(
                              tabs: categoriesGet.map((kategori) {
                                if (kategori["id"] == 99) {
                                  return Tab(
                                    icon: FaIcon(
                                            FontAwesomeIcons.home,
                                            size: 20,
                                          ), 
                                  );
                                }
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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: categoriesGet.map((kategori) {
                                return TabBodyPage(
                                  categoryId: kategori["id"],
                                  title: kategori["title"],
                                );
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
