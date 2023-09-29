import 'package:mindflow/model/ArticleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'catcedImage.dart';

class Card5 extends StatelessWidget {
  final ArticleModel articleModel;
  Card5({Key? key, required this.articleModel});

  @override
  Widget build(BuildContext context) {
 final DateTime date = DateTime.parse(articleModel.date);
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: Offset(0, 3))
              ]),
          child: Wrap(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: CustomCacheImage(
                      imageUrl: articleModel.articleImage,
                      radius: 5.0,
                      circularShape: false,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articleModel.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.time,
                          size: 16,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                      Text(
                          timeago.format(date, locale: "tr"),
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 10),
                        ),
                        /*     Spacer(),
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.loves.toString(),
                        style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor),
                      )  */
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () async {});
  }
}
