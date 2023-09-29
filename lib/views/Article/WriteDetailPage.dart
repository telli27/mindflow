import 'dart:developer';

import 'package:mindflow/config/appConfig.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../provider/articleCtx.dart';

class WriteDetailPage extends StatefulWidget {
  const WriteDetailPage({super.key});

  @override
  State<WriteDetailPage> createState() => _WriteDetailPageState();
}

class _WriteDetailPageState extends State<WriteDetailPage> {
  final QuillEditorController controller = QuillEditorController();
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  bool _hasFocus = false;
  @override
  void initState() {
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    controller.enableEditor(true);
    super.initState();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    super.dispose();
  }

  dynamic detail = "";
  @override
  Widget build(BuildContext context) {
        final articleCtx = Provider.of<ArticleCtx>(context, listen: true);

    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor:Colors.white,
            elevation: 0,
            title: Text("Detay",style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),),
            actions: [
              IconButton(
                  onPressed: () async {
                    getHtmlText();
                  },
                  icon: FaIcon(FontAwesomeIcons.save)),
            ],
          ),
          body: Column(
            children: [
              ToolBar(
                toolBarColor: Colors.cyan.shade50,
                activeIconColor: Colors.green,
                padding: const EdgeInsets.all(8),
                iconSize: 20,
                controller: controller,
              ),
              Expanded(
                child: QuillHtmlEditor(
                    hintText: 'Detay',
                    text: articleCtx.detailArticle,
                    controller: controller,
                    isEnabled: true,
                    minHeight: 300,
                    textStyle: _editorTextStyle,
                    hintTextStyle: _hintTextStyle,
                    hintTextAlign: TextAlign.start,
                    padding: const EdgeInsets.only(left: 10, top: 5,right: 10),
                    hintTextPadding: EdgeInsets.zero,
                    backgroundColor: _backgroundColor,
                    onFocusChanged: (hasFocus) =>
                        debugPrint('has focus $hasFocus'),
                    onTextChanged: (text) => text,
                    onEditorCreated: () {
                      debugPrint('Editor has been loaded');
                    },
                    onEditorResized: (height) =>
                        debugPrint('Editor resized $height'),
                    onSelectionChanged: (sel) => sel),
              ),
            ],
          )),
    );
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    final articleCtx = Provider.of<ArticleCtx>(context, listen: false);

    String? htmlText = await controller.getText();
    log(htmlText);
    articleCtx.detailArticle = htmlText;
    Navigator.pop(context);
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }
}
