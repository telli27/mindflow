import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mindflow/model/usermodel.dart';

import '../../model/ArticleModel.dart';
import '../../model/User_Model.dart';
import '../profile/WriteArticleUserProfile.dart';

class ArticleDetail extends StatefulWidget {
  ArticleModel article;
  dynamic articleId;
  ArticleDetail({
    Key? key,
    required this.article,
    required this.articleId,
  }) : super(key: key);

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  UserModel? _getUserModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _getArticleWriteUser() async {
    // Firebase Authentication ile oturum açmış kullanıcının bilgilerini alın
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Firebase Firestore bağlantısını başlatın

      // Kullanıcının UID'sini kullanarak belirli bir belgeyi alın
      DocumentSnapshot userDoc =
          await firestore.collection('User').doc(widget.article.userId).get();
      setState(() {});
      if (userDoc.exists) {
        // Kullanıcının bilgilerini alın
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        _getUserModel = UserModel.fromMap(userData);
        // Kullanıcı bilgilerini kullanabilirsiniz
        print('Kullanıcı adı: ${_getUserModel!.userName}');
        print('E-posta: ${userData['email']}');
        // Diğer bilgileri burada kullanabilirsiniz
        setState(() {});
        // notifyListeners(); // Bu bağlamda notifyListeners kullanmanız gereken bir bağlam varsa kullanabilirsiniz.
      } else {
        print('Kullanıcı bulunamadı');
      }
      setState(() {});
    } else {
      print('Kullanıcı oturumu açmamış');
    }
  }

  bool? isLiked;
  Future<void> checkIfUserLikedArticle() async {
    final likeRef = _firestore
        .collection('likesArticle')
        .doc('${widget.articleId}-${_auth.currentUser!.uid}');

    final likeDoc = await likeRef.get();

    setState(() {
      isLiked = likeDoc.exists;
    });
  }

  @override
  void initState() {
    super.initState();
    log("article id ${widget.articleId}");
    _getArticleWriteUser();
    checkIfUserLikedArticle();
    _readArticle(widget.articleId, _auth.currentUser!.uid);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Bir makaleye beğeni eklemek için
  Future<void> likeArticle(String articleId, String userId) async {
    final likeRef =
        _firestore.collection('likesArticle').doc('$articleId-$userId');

    final likeDoc = await likeRef.get();

    if (likeDoc.exists) {
      // Kullanıcı daha önce beğenmiş, bu yüzden beğeniyi kaldırın
      await likeRef.delete();

      // Beğeni sayısını azaltın
      await _firestore.collection('articles').doc(articleId).update({
        'likesCount': FieldValue.increment(-1),
      });

      // isLiked değerini güncelle (false olarak ayarla)
      setState(() {
        isLiked = false;
      });
    } else {
      // Kullanıcı daha önce beğenmemiş, bu yüzden beğeni ekleyin
      await likeRef.set({
        'articleId': articleId,
        'userId': userId,
      });

      // Beğeni sayısını artırın
      await _firestore.collection('articles').doc(articleId).update({
        'likesCount': FieldValue.increment(1),
      });

      // isLiked değerini güncelle (true olarak ayarla)
      setState(() {
        isLiked = true;
      });
    }
  }

// Bir makaleye verilen bir kullanıcı tarafından beğeni eklenip eklenmediğini kontrol etmek için
  Future<bool> isArticleLiked(String articleId, String userId) async {
    final likeDoc = await _firestore
        .collection('likesArticle')
        .doc('$articleId-$userId')
        .get();
    return likeDoc.exists;
  }

  int? _readCount;

  void _readArticle(String articleId, String userId) async {
    final readRef =
        _firestore.collection('readsArticle').doc('$articleId-$userId');

    final likeDoc = await readRef.get();

    if (likeDoc.exists) {
    } else {
      await readRef.set({'articleId': articleId, 'userId': userId});

      // Beğeni sayısını artırın
      await _firestore.collection('articles').doc(articleId).update({
        'readCount': FieldValue.increment(1),
      });

      // isLiked değerini güncelle (true olarak ayarla)
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black)
            : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
     
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.article.articleImage,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 1.4,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 45, left: 20),
                            child: FaIcon(
                              FontAwesomeIcons.circleChevronLeft,
                              size: 30,
                              color:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.white,
                            ),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 15, top: 5),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color.fromARGB(26, 47, 46, 46)
                                : Color.fromARGB(255, 248, 246, 246)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return WriteUserProfilePage(
                                    userModel: _getUserModel!,
                                  );
                                },
                              ));
                            },
                            child:
                        Align(
                            alignment: Alignment.topCenter,
                            child: _getUserModel==null
                                ? Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                     
                                      border: Border.all(
                                          width: 3, color: Colors.orange),
                                    ),
                                  child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.userAstronaut,
                                        color:Theme.of(context).brightness ==
                                            Brightness.dark? Colors.white:Colors.black,
                                        size: 40,
                                      ),
                                    ),
                                )
                                : Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                        _getUserModel == null
                                            ? ""
                                            : _getUserModel!.image ?? "",
                                      ),
    
                                      ),
                                      border: Border.all(
                                          width: 3, color: Colors.orange),
                                    ),
                                  )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserModel == null
                                    ? ""
                                    : _getUserModel!.seeName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Color.fromARGB(255, 2, 52, 93)),
                              ),
                              Text(
                                _getUserModel == null
                                    ? ""
                                    : _getUserModel!.userName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 156, 158, 160)),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
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
    
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (isLiked!) {
                                            // Beğeniyi kaldır
                                            await likeArticle(widget.articleId,
                                                _auth.currentUser!.uid);
                                          } else {
                                            // Beğeni ekle
                                            await likeArticle(widget.articleId,
                                                _auth.currentUser!.uid);
                                          }
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.thumbsUp,
                                          color: isLiked == true
                                              ? Colors.blue
                                              : Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        likesCount.toString() ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 156, 158, 160),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
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
                                  final readCount =
                                      articleData?.get('readCount') ?? 0;
    
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.eye,
                                        size: 20,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        readCount == null
                                            ? "0"
                                            : readCount.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.shareNodes,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Paylaş",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 156, 158, 160)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        widget.article.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Color.fromARGB(255, 2, 52, 93)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: HtmlWidget(
                    widget.article.detail,
                    textStyle: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500, height: 2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Kaynak : ",
                          style: TextStyle(
                              color:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black),
                        ),
                        /*
           Text( widget.article.source!??"",
                          style: TextStyle(color: Colors.black),
                        )
                     */
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
