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
import '../widgets/MyNavigationBar.dart';
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
    super.dispose();
  }



  // Platform messages are asynchronous, so we initialize in an async method.

  Widget renderTitle(String text) {
    const textStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
    return Text(text, style: textStyle);
  }


 

  var _pages = [
    Home(),
    CategoriesPage(),
    Container(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);
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
     
            body: _pages[articleCtx.selectedIndex],
            bottomNavigationBar: MyNavigationBar(
              backgroundColor: Colors.white10,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              onItemTap: (int tappedIndex) {
                print('Tapped index: $tappedIndex');
                if(tappedIndex==2){
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return WriteArticle();
                    },
                  ));
                }else{
                  articleCtx.changeSelected(tappedIndex);
                }
                
              },
              destinations: const [
                NavigationDestination(
                  icon: FaIcon(FontAwesomeIcons.home),
                  label: "Ana Sayfa",
                ),
                NavigationDestination(
                  icon: FaIcon(FontAwesomeIcons.clipboardList),
                  label: "Kategoriler",
                ),
                NavigationDestination(
                  icon: FaIcon(FontAwesomeIcons.edit),
                  label: "İçerik Oluştur",
                ),
                NavigationDestination(
                  icon: FaIcon(FontAwesomeIcons.gear),
                  label: "Ayarlar",
                ),
              ],
            ),
          ),
        ));
  }
}
