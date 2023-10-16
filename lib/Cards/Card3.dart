import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:mindflow/model/ArticleModel.dart';
import 'package:mindflow/provider/articleCtx.dart';

import '../views/Article/ArticleDetail.dart';
import 'catcedImage.dart';

class Card3 extends StatefulWidget {
  bool profile;
  final ArticleModel d;
  ValueChanged onBackState;
  final dynamic articleId;
  Card3({
    Key? key,
    required this.profile,
    required this.d,
    required this.onBackState,
    required this.articleId,
  }) : super(key: key);

  @override
  State<Card3> createState() => _Card3State();
}

class _Card3State extends State<Card3> {
  String categoriesName = "";
  Future<void> deleteArticleById(String articleId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      try {
        // Kullanıcının isAdmin alanına bak
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('User')
            .doc(userId)
            .get();
        bool isAdmin = userDoc['isAdmin'] ??
            false; // Varsayılan olarak false kabul ediyoruz

        if (isAdmin) {
          // Eğer kullanıcı adminse, makaleyi sil
          await FirebaseFirestore.instance
              .collection('articles')
              .doc(articleId)
              .delete();
          print('Makale silindi.');
        } else {
          print('Kullanıcı admin değil.');
        }
      } catch (e) {
        print('Hata: $e');
      }
    } else {
      print('Oturum açmış bir kullanıcı yok.');
    }
  }

  bool _isAdmin = false;
  void isAdminCheck() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    bool isAdmin =
        userDoc['isAdmin'] ?? false; // Varsayılan olarak false kabul ediyoruz
    if (isAdmin == true) {
      _isAdmin = isAdmin;
      setState(() {});
    }
  }

  Future<void> deleteArticleByIdUser(String articleId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      try {
        // Eğer kullanıcı adminse, makaleyi sil
        await FirebaseFirestore.instance
            .collection('articles')
            .doc(articleId)
            .delete();
        print('Makale silindi.');
      } catch (e) {
        print('Hata: $e');
      }
    } else {
      print('Oturum açmış bir kullanıcı yok.');
    }
  }

  @override
  void initState() {
    super.initState();
      isAdminCheck();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.parse(widget.d.date);
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);
    log("d.categoryId* **  ${widget.d.categoryId}  articleCtx.categories ${articleCtx.categories.length}");

    articleCtx.categories.map((value) {
      log("value* * $value");
      if (value["id"] == widget.d.categoryId) {
        categoriesName = value["title"];
      }
    }).toList();
    return InkWell(
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 10,
                        offset: Offset(0, 3))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: CustomCacheImage(
                            imageUrl: widget.d.articleImage, radius: 8.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          widget.d.title,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.time,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            timeago.format(date, locale: "tr"),
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          StreamBuilder<DocumentSnapshot<Object?>>(
                            stream: FirebaseFirestore.instance
                                .collection('articles')
                                .doc(widget.articleId)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot<Object?>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              final articleData = snapshot.data;
                              final likesCount =
                                  articleData?.get('likesCount') ?? 0;

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.thumbsUp,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    likesCount.toString() ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 156, 158, 160),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )),
          if (_isAdmin == true) ...{
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    deleteArticleById(widget.articleId);
                    setState(() {});
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ),
              ),
            ),
          } else if (widget.profile == true) ...{
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    deleteArticleByIdUser(widget.articleId);
                    setState(() {});
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ),
              ),
            )
          },
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 108, 66, 2)),
                  child: Text(
                    "Okunma Süresi: " + widget.d.readTime.toString() + " dk",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          /* Positioned(
            top: 5,
            right: 10,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      Color.fromARGB(255, 1, 73, 66) /*Colors.blueGrey[600]*/),
              child: Text(
                categoriesName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),*/
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ArticleDetail(
                article: widget.d, articleId: widget.articleId);
          },
        )).then((value) {
          setState(() {});
          widget.onBackState("merhaba");
        });
      },
    );
  }
}
