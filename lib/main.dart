import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:mindflow/provider/articleCtx.dart';
import 'package:mindflow/provider/themeCtx.dart';
import 'package:mindflow/views/ArticleStart.dart';
import 'package:mindflow/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'model/ThemeModel.dart';
import 'provider/authCtx.dart';
import 'provider/categoriesCtx.dart';
import 'views/registerandlogin/loginandRegister.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  await Hive.openBox('myThemeBox');
  await Firebase.initializeApp();
SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ArticleCtx>(create: (_) => ArticleCtx()),
          ChangeNotifierProvider<CategoriesCtx>(create: (_) => CategoriesCtx()),
          ChangeNotifierProvider<AuthCtx>(create: (_) => AuthCtx()),
          ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(builder: ((context, value, child) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: value.theme == false
                ? ThemeModel().lightMode
                : ThemeModel().darkMode,
            darkTheme: ThemeModel().darkMode,
            title: "Mindflow",
            home: Splash(),
            //    builder: EasyLoading.init(),
          );
        })));
  }
}
