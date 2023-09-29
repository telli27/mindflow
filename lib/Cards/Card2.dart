import 'package:mindflow/model/ArticleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'catcedImage.dart';

class Card2 extends StatelessWidget {
  final ArticleModel d;
  const Card2({
    Key? key,
    required this.d,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.parse(d.date);
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
                      imageUrl: d.articleImage,
                      radius: 5.0,
                      circularShape: false,
                    ),
                  ),
                
                ],
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "spot",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).secondaryHeaderColor)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.time,
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          timeago.format(date, locale: "tr"),
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                        /*

   Spacer(),
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.loves.toString(),
                        style: TextStyle(fontSize: 12, color: Theme.of(context).secondaryHeaderColor),
                      )

                   */
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {});
  }
}
