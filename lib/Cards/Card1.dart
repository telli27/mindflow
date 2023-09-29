import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../model/ArticleModel.dart';
import '../provider/articleCtx.dart';
import 'catcedImage.dart';

class Card1 extends StatelessWidget {
  final ArticleModel d;

  Card1({
    Key? key,
    required this.d,
  });

  String categoriesName = "";
  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.parse(d.date);
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);
    log("d.categoryId* **  ${d.categoryId}  articleCtx.categories ${articleCtx.categories.length}");

    articleCtx.categories.map((value) {
      log("value* * $value");
      if (value["id"] == d.categoryId) {
        categoriesName = value["title"];
      }
    }).toList();
    return InkWell(
      child: Container(
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      

     Container(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey[600]),
                          child: Text(
                           categoriesName,
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),


                   
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //       color: Colors.grey[200],
                            //       blurRadius: 1,
                            //       offset: Offset(1, 1))
                            // ],
                          ),
                          child: CustomCacheImage(
                              imageUrl: d.articleImage, radius: 5.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.time,
                    color: Colors.grey,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    timeago.format(date, locale: "tr"),
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 10),
                  ),
                  /*
                
                  Spacer(),
                  Icon(
                    Icons.favorite,
                    color: Theme.of(context).secondaryHeaderColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(d.loves.toString(),
                      style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 13)),
              
                
                */
                ],
              )
            ],
          )),
      onTap: () {},
    );
  }
}
