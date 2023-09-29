import 'dart:developer';
import 'dart:io';

import 'package:mindflow/provider/articleCtx.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../services/Storeservices.dart';
import '../../../widgets/TextInputWidget.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({super.key});

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  StorageServices storageServices = StorageServices();

  @override
  Widget build(BuildContext context) {
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 0,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 0, top: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: Duration(seconds: 5),
                        message:
                            " 'Makale' \nSize Ait ise Eğer Kaynak Olarak Kullanıcı Adınızı Belirtebilirsiniz",
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Expanded(
                            child: TextInputWidget(
                              controller: articleCtx.sourcheCtx,
                              hintText: "Kaynak Belirtin",
                              readOnly: false,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                   articleCtx.articleImage == null
                ?    Padding(
                        padding: const EdgeInsets.only(right: 0.0),
                        child: TextFormField(
                          maxLines: 20,
                          onTap: () {
                            articleCtx.selectImageArticle(ImageSource.gallery,
                                context: context);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            suffixIcon: Center(
                              child: Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.image,
                                    size: 100,
                                  ),
                                  Text(
                                    "Resim Seç",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 28.0, horizontal: 12.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.blue.withOpacity(0.2),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Color(0xFFF6F5F5),
                                width: 1.0,
                              ),
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF6F5F5)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          readOnly: true,
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          onSaved: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Detay Boş Olamaz";
                            }
                            return null;
                          },
                        ),
                      ): Column(
                      children: [
                        Text(
                          "Seçilen Resim",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            articleCtx.selectImageArticle(ImageSource.gallery,
                                context: context);
                          },
                          child: Container(
                            height: 400,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(articleCtx.articleImage!.path),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ],
                  )
                
          ),
        ),
      ),
    );
  }
}
/*

     if (data.profileImage != null) {
                String mediaUrl = await storageServices
                    .uploadMedia(File(data.profileImage!.path));
                yaziModel = yaziModel..image = mediaUrl;
              }
*/