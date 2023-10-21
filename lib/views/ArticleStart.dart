import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:status_bar_control/status_bar_control.dart';
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
    initPlatformState();

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

  double? _statusBarHeight = 0.0;
  bool _statusBarColorAnimated = false;
  Color? _statusBarColor = Colors.black;
  double _statusBarOpacity = 1.0;
  bool _statusBarHidden = false;
  StatusBarAnimation _statusBarAnimation = StatusBarAnimation.NONE;
  StatusBarStyle _statusBarStyle = StatusBarStyle.DEFAULT;
  bool _statusBarTranslucent = false;
  bool _loadingIndicator = false;
  bool _fullscreenMode = false;

  bool _navBarColorAnimated = false;
  Color? _navBarColor = Colors.black;
  NavigationBarStyle? _navBarStyle = NavigationBarStyle.DEFAULT;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    double? statusBarHeight;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      statusBarHeight = await StatusBarControl.getHeight;
    } on PlatformException {
      statusBarHeight = 0.0;
    }
    if (!mounted) return;

    setState(() {});
  }

  Widget renderTitle(String text) {
    const textStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
    return Text(text, style: textStyle);
  }

  void colorBarChanged(Color val) {
    setState(() {
      _statusBarColor = val;
    });
    updateStatusBar();
  }

  void updateStatusBar() {
    StatusBarControl.setColor(_statusBarColor!.withOpacity(_statusBarOpacity),
        animated: _statusBarColorAnimated);
  }

  void statusBarAnimationChanged(StatusBarAnimation val) {
    setState(() {
      _statusBarAnimation = val;
    });
  }

  void statusBarStyleChanged(StatusBarStyle val) {
    setState(() {
      _statusBarStyle = val;
    });
    StatusBarControl.setStyle(val);
  }

  void colorNavBarChanged(Color val) {
    setState(() {
      _navBarColor = val;
    });
    updateNavBar();
  }

  void updateNavBar() {
    StatusBarControl.setNavigationBarColor(_navBarColor!,
        animated: _navBarColorAnimated);
  }

  void navigationBarStyleChanged(NavigationBarStyle val) {
    setState(() {
      _navBarStyle = val;
    });
    StatusBarControl.setNavigationBarStyle(val);
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
