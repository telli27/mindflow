import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import 'package:mindflow/config/appConfig.dart';
import 'package:mindflow/provider/authCtx.dart';
import 'package:mindflow/services/auth.dart';
import 'package:mindflow/views/navPages/Home.dart';
import 'package:mindflow/views/navPages/categoriesPage.dart';

import '../provider/articleCtx.dart';
import 'Article/WriteArticle.dart';
import 'navPages/setting.dart';
import 'registerandlogin/loginandRegister.dart';

class ArticleStart extends StatefulWidget {
  int index;
  ArticleStart({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ArticleStart> createState() => _ArticleStartState();
}

class _ArticleStartState extends State<ArticleStart> {
  final Color navigationBarColor = Colors.white;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
       // Status bar rengini beyaz yap
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // Status bar rengi
      statusBarIconBrightness: Brightness.dark, // Simge rengi (siyah)
    ));
    context.read<AuthCtx>().getCurrentUser();

    pageController =
        PageController(initialPage: context.read<ArticleCtx>().selectedIndex);
    if (widget.index != null) {
      context.read<ArticleCtx>().selectedIndex = widget.index;
    }
  }

  @override
  void dispose() {
    // Status bar rengini varsayılana geri döndür
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }

  var _pages = [
    Home(),
    CategoriesPage(),
    Container(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
       setState(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        statusBarBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ));
    });
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        statusBarBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ));
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarBrightness: Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          statusBarColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
        ),
        child: WillPopScope(
          onWillPop: () async {
            return null!;
          },
          child: Scaffold(
              backgroundColor: Colors.grey[100],
              body: _pages[articleCtx.selectedIndex],
              bottomNavigationBar: BottomBar()),
        ));
  }
}

class BottomBar extends StatefulWidget {
  BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final primaryColor = const Color(0xff4338CA);

  final secondaryColor = const Color(0xff6D28D9);

  final accentColor = const Color(0xffffffff);

  final backgroundColor = const Color(0xffffffff);

  final errorColor = const Color(0xffEF4444);
  int? selected;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);

    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconBottomBar(
                  text: "Ana Sayfa",
                  icon: FontAwesomeIcons.home,
                  selected: articleCtx.selectedIndex == 0 ? true : false,
                  onPressed: () {
                    articleCtx.changeSelected(0);
                  }),
              IconBottomBar(
                  text: "Kategoriler",
                  icon: FontAwesomeIcons.clipboardList,
                  selected: articleCtx.selectedIndex == 1 ? true : false,
                  onPressed: () {
                    articleCtx.changeSelected(1);
                  }),
              IconBottomBar(
                  text: "İçerik Oluştur",
                  icon: FontAwesomeIcons.edit,
                  selected: articleCtx.selectedIndex == 2 ? true : false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WriteArticle();
                      },
                    ));
                  }),
              IconBottomBar(
                  text: "Ayarlar",
                  icon: FontAwesomeIcons.gear,
                  selected: articleCtx.selectedIndex == 3 ? true : false,
                  onPressed: () {
                    articleCtx.changeSelected(3);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  //final primaryColor =// const Color(0xff4338CA);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? Colors.black : Color.fromARGB(137, 62, 62, 62),
          ),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 13,
              height: .2,
              color: selected ? Colors.black : Colors.grey.withOpacity(.75)),
        )
      ],
    );
  }
}
