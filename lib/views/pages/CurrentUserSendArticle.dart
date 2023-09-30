import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Cards/Card3.dart';
import '../../model/ArticleModel.dart';

class CurrentUserSendArticle extends StatelessWidget {
  CurrentUserSendArticle({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
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
              onEmpty: Center(
                child: Text("Paylaşılmış Makale bulunamadı"),
              ),
              query: FirebaseFirestore.instance
                  .collection('articles')
                  .where('userId', isEqualTo: auth.currentUser!.uid),
    
              itemBuilder: (context, documentSnapshot, index) {
                   var articles = documentSnapshot.data() as Map<String, dynamic>?;
                var articleId = documentSnapshot.id; // Döküman ID'sini alın
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card3(
                    d: ArticleModel.fromMap(articles!),articleId:articleId,
                    onBackState: (value) {},
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 300,
          )
        ],
      ),
    );
  }
}
