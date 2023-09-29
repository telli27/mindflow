import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

import '../../../provider/articleCtx.dart';
import '../../../widgets/previewWidget.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
              width: MediaQuery.of(context).size.width * 1,
               height: 400,
              decoration: BoxDecoration(
                 
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerLeft, child:   ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        File(articleCtx.articleImage!.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        
            SizedBox(
              height: 5,
            ),
             Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 49,
              decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    articleCtx.titleCtx.text.toString().toString(),
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
        
            SizedBox(
              height: 5,
            ),
              Container(
              width: MediaQuery.of(context).size.width * 90,
              // height: 49,
              margin: EdgeInsets.only(
                left: 10,right: 10
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:  HtmlWidget(
                      articleCtx.detailArticle,
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        
            
          ],
        ),
      ),
    );
  }
}
