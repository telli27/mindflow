import 'package:mindflow/config/appConfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../model/usermodel.dart';
import '../../provider/authCtx.dart';
import '../pages/CurrentUserSendArticle.dart';
import 'WriteUserArticle.dart';

class WriteUserProfilePage extends StatefulWidget {
  UserModel userModel;
  WriteUserProfilePage({super.key, required this.userModel});
  @override
  State<WriteUserProfilePage> createState() => _WriteUserProfilePageState();
}

class _WriteUserProfilePageState extends State<WriteUserProfilePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 0, bottom: 5),
            child: CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.black,
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Makale Yazarının Profili",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.userModel!.image!,
                              ),
                            ),
                            border: Border.all(width: 3, color: Colors.orange),
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.userModel.seeName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppConfig.appColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "@${widget.userModel.userName} ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: HexColor("#A5A5A5")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Biyografi :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decorationStyle: TextDecorationStyle.wavy,
                                    decoration: TextDecoration.underline),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 30, bottom: 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              widget.userModel.bio != ""
                                  ? widget.userModel.bio!
                                  : "Biografi boş",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        indicatorColor: Colors.black,
                        labelColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.blue
                                : Colors.white,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        tabs: [
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Center(
                                child: Text("Makaleler"),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Center(
                                child: Text("Yazılar"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(children: <Widget>[
                          WriteUserSendArticle(
                            userModel: widget.userModel,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Center(
                              child: Text("Çok Yakında.. beklemede kalın :))"),
                            ),
                          )
                        ]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
