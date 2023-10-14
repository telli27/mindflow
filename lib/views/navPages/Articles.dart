import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindflow/model/ArticleModel.dart';
import 'package:mindflow/Cards/Card3.dart';

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
  late Stream<QuerySnapshot> _articleStream;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _articleStream = FirebaseFirestore.instance
        .collection('articles')
        .where('categoryId', isEqualTo: widget.categoryId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _articleStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
              child:
                  Text("${widget.title} ile ilgili bir paylaşım bulunamadı"));
        } else {
          final articles = snapshot.data!.docs;
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification &&
                  _scrollController.position.extentAfter == 0) {
                // Load more articles when the user reaches the end of the list.
                // You can implement your logic here.
              }
              return false;
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final articleData =
                    articles[index].data() as Map<String, dynamic>;
                final articleId = articles[index].id;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card3(
                    d: ArticleModel.fromMap(articleData),
                    articleId: articleId,
                    onBackState: (bb) {
                      // Handle your onBackState logic here
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
