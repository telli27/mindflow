import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/ArticleModel.dart';
import '../services/Storeservices.dart';
import '../views/ArticleStart.dart';
import '../views/navPages/Home.dart';
import '../widgets/showMesages.dart';

class ArticleCtx extends ChangeNotifier {
  int selectedIndex = 0;
  String detailArticle = "";
  dynamic selectedCategory;
  dynamic selectedReadTime;
  List<Map<String, dynamic>> readList = [
    {"name": "2", "id": 2},
    {"name": "3", "id": 3},
    {"name": "4", "id": 4},
    {"name": "5", "id": 5},
    {"name": "6", "id": 6},
    {"name": "7", "id": 7},
    {"name": "8", "id": 8},
    {"name": "10", "id": 10}
  ];

  Map<String, dynamic> selectedCategoryJson = {};
  String selectedCategoryName = "";
  TextEditingController titleCtx = TextEditingController();
  TextEditingController sourcheCtx = TextEditingController(text: "");

  changeSelected(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  ArticleCtx() {
    fetchCategories();
  }
  Future<void> addArticleToFirestore(
    String userId,
    String userProfileImage,
    String title,
    String detail,
    String articleImage,
    bool readArticle,
    String categoryId, // Kategori kimliği ekleniyor.
  ) async {
    final CollectionReference articles =
        FirebaseFirestore.instance.collection('articles');

    try {
      await articles.add({
        'userId': userId,
        'userProfileImage': userProfileImage ?? "",
        'title': title,
        'detail': detail,
        'articleImage': articleImage ?? "",
        'readArticle': readArticle,
        'categoryId': categoryId, // Kategori kimliğini Firestore'a ekleyin.
        'createArticleDate': FieldValue.serverTimestamp(),
      });
      print('Makale Firestore\'a eklendi.');
    } catch (e) {
      print('Makale eklenirken hata oluştu: $e');
    }
  }

  Stream<QuerySnapshot> getArticlesByCategory(
    String categoryId,
    int batchSize,
    DocumentSnapshot? lastDocument,
  ) {
    Query query = FirebaseFirestore.instance
        .collection('articles')
        .where('categoryId', isEqualTo: categoryId)
        .orderBy('createArticleDate', descending: true)
        .limit(batchSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots();
  }

  List<Map<String, dynamic>> categories = [];
  Future<void> fetchCategories() async {
    // Firestore bağlantısını başlatın

    // Firestore koleksiyonunu referans alın
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('categories');

    // Kategorileri Firestore'dan çekin
    QuerySnapshot querySnapshot = await categoriesCollection.get();

    // Firestore'dan gelen verileri listeye dönüştürün

    categories = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    notifyListeners();
  }

  XFile? articleImage = null;
  dynamic? pickImage;

  final ImagePicker _pickerImage = ImagePicker();
  StorageServices storageServices = StorageServices();
  String mediaUrl = "";
  void selectImageArticle(ImageSource source,
      {required BuildContext context}) async {
    try {
      var permission =
          Platform.isAndroid ? Permission.storage : Permission.photos;
      var permissionStatus = await permission.request();

      print("isGranted: " +
          permissionStatus.isGranted.toString() +
          " isDenied: " +
          permissionStatus.isDenied.toString() +
          " isLimited: " +
          permissionStatus.isLimited.toString() +
          " isRestricted: " +
          permissionStatus.isRestricted.toString() +
          " isPermanentlyDenied: " +
          permissionStatus.isPermanentlyDenied.toString());

      //  print(status.isDenied.toString());
      if (permissionStatus.isPermanentlyDenied == true) {
        openAppSettings();
      } else {
        final pickedFile = await _pickerImage.pickImage(source: source);

        File compressedFile = await FlutterNativeImage.compressImage(
          pickedFile!.path,
          quality: 100,
        );

        articleImage = XFile(compressedFile.path);

        if (articleImage != null) {}
        notifyListeners();
        print('aaa');
      }
      notifyListeners();
    } catch (e) {
      pickImage = e;
      print("Image Error: " + pickImage);
    }
  }

  Future<void> sendArticle(ArticleModel article, BuildContext context) async {
    try {
      titleCtx.text = "";
      detailArticle = "";
      selectedCategory = null;
      selectedReadTime = null;
      await FirebaseFirestore.instance
          .collection('articles')
          .add(article.toMap());
      EasyLoading.dismiss();
      showMessage("Makale Başarılı Şekilde Paylaşıldı..");
      selectedIndex = 0;
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ArticleStart(
            index: 0,
          );
        },
      ));
    } catch (e) {
      EasyLoading.dismiss();
      print('Makale eklenirken bir hata oluştu: $e');
    }
  }

  bool? isTestOpen;
  String message = "";
  Future<void> checkTestField() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('config').limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        // İlk dokümanı alıyoruz çünkü sorgu sonucunda sadece bir doküman çekeceğiz.
        DocumentSnapshot doc = querySnapshot.docs.first;
        isTestOpen = doc['test']; // Varsayılan olarak "test" alanınızın adı
        message = doc['message']; // Varsayılan olarak "test" alanınızın adı
        log("message ** * $message");
        if (isTestOpen == true) {
          print("Test açık");
        } else {
          print("Test açık değil");
        }
      } else {
        print("Belirli bir doküman bulunamadı.");
      }
    } catch (e) {
      print("Hata: $e");
    }
  }
}

ArticleCtx articleCtx = ArticleCtx();
