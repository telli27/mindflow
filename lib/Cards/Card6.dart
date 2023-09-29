import 'package:mindflow/model/ArticleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

import 'catcedImage.dart';

class Card6 extends StatelessWidget {
  final ArticleModel d;

  const Card6({Key ?key, required this.d})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.parse(d.date);

    return InkWell(
      child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom: 0),
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
              Flexible(
                flex: 0,
                child:Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            //  height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 60,
                            width: 100,
                            child: CustomCacheImage(
                                imageUrl: d.articleImage, radius: 5.0),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                width: 15,
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      d.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.time,
                          color: Theme.of(context).secondaryHeaderColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                      
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
      onTap: () {
      
      },
    );
  }
}
