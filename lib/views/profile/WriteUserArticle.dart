import 'dart:developer';

import 'package:mindflow/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Cards/Card3.dart';
import '../../model/ArticleModel.dart';

class WriteUserSendArticle extends StatefulWidget {
  UserModel userModel;
  WriteUserSendArticle({super.key, required this.userModel});

  @override
  State<WriteUserSendArticle> createState() => _WriteUserSendArticleState();
}

class _WriteUserSendArticleState extends State<WriteUserSendArticle> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: FirestorePagination(
            limit: 5, // Defaults to 10.
            viewType: ViewType.list,
            bottomLoader: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.blue,
              ),
            ),
            query: FirebaseFirestore.instance
                .collection('articles')
                .where('userId', isEqualTo: widget.userModel.id)
                .orderBy('date', descending: true),

            itemBuilder: (context, documentSnapshot, index) {
              var articles = documentSnapshot.data() as Map<String, dynamic>?;
              log("articles ** ** $articles");
                            var articleId = documentSnapshot.id; // Döküman ID'sini alın

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card3(d: ArticleModel.fromMap(articles!), onBackState: (value) { 
              setState(() {
                
              });
                 }, articleId: articleId, profile: true,),
              );
            },
          ),
        ),
        SizedBox(
          height: 300,
        )
      ],
    );
  }
}
