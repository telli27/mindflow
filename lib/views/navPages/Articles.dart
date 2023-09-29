import 'dart:developer';

import 'package:mindflow/Cards/Card1.dart';
import 'package:mindflow/Cards/Card2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';

import 'package:mindflow/Cards/Card3.dart';
import 'package:mindflow/Cards/Card4.dart';
import 'package:mindflow/Cards/Card5.dart';
import 'package:mindflow/Cards/Card6.dart';
import 'package:mindflow/model/ArticleModel.dart';

class TabBodyPage extends StatefulWidget {
  final int categoryId;
  String title;
  TabBodyPage({
    Key? key,
    required this.categoryId,
    required this.title,
  }) : super(key: key);

  @override
  State<TabBodyPage> createState() => _TabBodyPageState();
}

class _TabBodyPageState extends State<TabBodyPage> {
  final int batchSize = 20;
  late Query<Map<String, dynamic>> _query;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _articleStream;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(
          Duration(seconds: 1),
          () {
            setState(() {
              FirebaseFirestore.instance
                  .collection('articles')
                  .where('categoryId', isEqualTo: widget.categoryId);
            });
          },
        );
      },
      child: FirestorePagination(
        limit: 5, // Defaults to 10.
      
        initialLoader: Center(
          child: CircularProgressIndicator(),
        ),
        viewType: ViewType.list,
        onEmpty: Center(
          child: Text("${widget.title} ile ilgili bir paylaşım bulunamadı"),
        ),
        bottomLoader: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.blue,
          ),
        ),
        query: FirebaseFirestore.instance
            .collection('articles')
            .where('categoryId', isEqualTo: widget.categoryId),

        itemBuilder: (context, documentSnapshot, index) {
          var articles = documentSnapshot.data() as Map<String, dynamic>?;
          var articleId = documentSnapshot.id; // Döküman ID'sini alın
          log("articleId* ** ** $articleId");
          if (articles!.length <= 0) {
            return Center(
              child: Text("İçerik Bulunamadı"),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card3(
              d: ArticleModel.fromMap(articles!),
              articleId: articleId,
              onBackState: (value) async {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('articles')
                          .where('categoryId', isEqualTo: widget.categoryId);
                    });
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
