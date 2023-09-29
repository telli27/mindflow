import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../provider/articleCtx.dart';
import '../../../widgets/TextInputWidget.dart';
import '../../Article/WriteDetailPage.dart';

class SelectedInfoArticle extends StatefulWidget {
  const SelectedInfoArticle({super.key});

  @override
  State<SelectedInfoArticle> createState() => _SelectedInfoArticleState();
}

class _SelectedInfoArticleState extends State<SelectedInfoArticle> {
  TextEditingController detailCtx = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 18),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: TextInputWidget(
                  controller: articleCtx.titleCtx,
                  hintText: "Makale Başlığı",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Boş Olamaz";
                    }
                    return null;
                  },
                  readOnly: false,
                ),
              ),
              DropdownButtonFormField<dynamic>(
                borderRadius: BorderRadius.circular(12),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Kategori Seç",
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 28.0,
                      horizontal: 12.0), // Burada padding ekleniyor
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
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  labelStyle: TextStyle(color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                value: articleCtx.selectedCategory == null
                    ? articleCtx.selectedCategory
                    : articleCtx.selectedCategory.toString(),
                onChanged: (newValue) {
                  setState(() {});
                },
                items: articleCtx.categories.map((category) {
                  return DropdownMenuItem<dynamic>(
                    value: category["id"].toString(),
                    onTap: () {
                      log("newValue* ** $category");
                      articleCtx.selectedCategory = category["id"];
                      articleCtx.selectedCategoryName = category["title"];
                      articleCtx.selectedCategoryJson = category;
                    },
                    child: Text(
                      category["title"]??"",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Kategori Seçmelisiniz";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<dynamic>(
                borderRadius: BorderRadius.circular(12),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Okuma Süresi Seç",
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 28.0,
                      horizontal: 12.0), // Burada padding ekleniyor
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
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  labelStyle: TextStyle(color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                value: articleCtx.selectedReadTime == null
                    ? articleCtx.selectedReadTime
                    : articleCtx.selectedReadTime.toString(),
                onChanged: (newValue) {
                  setState(() {});
                },
                items: articleCtx.readList.map((raedValue) {
                  return DropdownMenuItem<dynamic>(
                    value: raedValue["id"].toString(),
                    onTap: () {
                      log("newValue* ** $raedValue");
                      articleCtx.selectedReadTime = raedValue["id"];
                    
                    },
                    child: Text(
                      raedValue["name"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Okuma Süresi Seçmelisiniz";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              articleCtx.detailArticle.isEmpty
                  ? Container(
                      child: TextFormField(
                        maxLines: 20,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return WriteDetailPage();
                            },
                          )).then((value) {
                            setState(() {});
                          });
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: "Detay",
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
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return WriteDetailPage();
                          },
                        )).then((value) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFFF6F5F5),
                            border: Border.all(width: 0.1)),
                        child: HtmlWidget(
                          articleCtx.detailArticle,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
