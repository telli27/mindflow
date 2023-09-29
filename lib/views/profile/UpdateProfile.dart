import 'dart:io';
import 'package:mindflow/config/appConfig.dart';
import 'package:mindflow/widgets/showMesages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../model/usermodel.dart';
import '../../services/Storeservices.dart';
import '../../services/updateProfile.dart';

class UpdateProfile extends StatefulWidget {
  final UserModel userModel;
  const UpdateProfile({super.key, required this.userModel});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController prevPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController bio = TextEditingController();
  final ImagePicker _pickerImage = ImagePicker();
  final ImagePicker _pickerImage2 = ImagePicker();
  UpdateProfileServices statusService = UpdateProfileServices();
  dynamic _pickImage;
  dynamic _pickImage2;
  XFile? profileImage;
  XFile? backgroundImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget imageProfile() {
    if (widget.userModel.image != null) {
      setState(() {
        _pickImage = widget.userModel.image;
      });
    }
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      print("resim : " + profileImage!.path);
      return CircleAvatar(
          maxRadius: MediaQuery.of(context).size.width * 0.16,
          backgroundColor: HexColor("#D9D9D9"),
          child: CircleAvatar(
            maxRadius: MediaQuery.of(context).size.width * 0.14,
            backgroundColor: Colors.blue,
            backgroundImage: FileImage(
              File(profileImage!.path),
            ),
          ));
    } else {
      if (_pickImage != null) {
        return CircleAvatar(
          maxRadius: MediaQuery.of(context).size.width * 0.16,
          backgroundColor: HexColor("#D9D9D9"),
          child: widget.userModel.image.toString().isEmpty
              ? Center(
                  child: FaIcon(
                    FontAwesomeIcons.userAstronaut,
                    color: Colors.black,
                    size: 40,
                  ),
                )
              : CircleAvatar(
                  maxRadius: MediaQuery.of(context).size.width * 0.14,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(widget.userModel.image!),
                ),
        );
      } else
        return Center(
          child: FaIcon(
            FontAwesomeIcons.userAstronaut,
            color: Colors.black,
            size: 40,
          ),
        );
    }
  }

  Widget imageBackgroundProfile() {
    if (widget.userModel.backgroundImage != null) {
      setState(() {
        _pickImage2 = widget.userModel.backgroundImage;
      });
    }
    if (backgroundImage != null) {
      print("resim : " + backgroundImage!.path);
      return Container(
        height: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(backgroundImage!.path),
                ))),
      );
    } else {
      if (_pickImage2 != null) {
        return Container(
          height: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.userModel.backgroundImage!))),
        );
      } else
        return Container(
          height: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        );
    }
  }

  StorageServices storageService = StorageServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.userModel.seeName!;
    username.text = widget.userModel.userName!;
    bio.text = widget.userModel.bio!;
  }

  bool adresVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil Ayarları",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  imageBackgroundProfile(),
                  Positioned(
                      left: MediaQuery.of(context).size.width * 0.3,
                      top: MediaQuery.of(context).size.height * 0.02,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              imageProfile(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                              Text(
                                widget.userModel.seeName!,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Positioned(
                            right: 0,
                            top: MediaQuery.of(context).size.width * 0.04,
                            child: InkWell(
                              onTap: () {
                                _selectProfileImage(ImageSource.gallery,
                                    context: context);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.087,
                                width: MediaQuery.of(context).size.width * 0.08,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              CustomPreviewPadding(
                context,
                "İsim",
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Center(
                    child: TextField(
                        controller: name,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          enabled: true,
                          hintText: "example",
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              CustomPreviewPadding(
                context,
                "Kullanıcı Adı",
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Center(
                    child: TextField(
                        controller: username,
                        maxLines: 1,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          enabled: true,
                          hintText: "@example",
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              CustomPreviewPadding(
                context,
                "Mevcut Şifre",
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Center(
                    child: TextField(
                        controller: prevPassword,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          enabled: true,
                          hintText: "******",
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              CustomPreviewPadding(
                context,
                "Yeni Şifre",
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Center(
                    child: TextField(
                        controller: newPassword,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isCollapsed: false,
                          enabled: true,
                          hintText: "Yeni şifre..",
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              CustomTextAreaPreviewMySkillsPadding(
                context,
                "Bio",
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: Center(
                    child: TextField(
                        controller: bio,
                        maxLines: 5,
                        maxLength: 300,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          enabled: true,
                          hintText: "bio..",
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 25, bottom: 10),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    UserModel userModel = widget.userModel;

                    if (profileImage != null) {
                      String mediaUrl = await storageService
                          .updateProfileMedia(File(profileImage!.path));
                      userModel = userModel..image = mediaUrl;
                    }

                    userModel = userModel
                      ..seeName = name.text
                      ..userName = username.text
                      ..bio = bio.text;

                    if (prevPassword.text.isNotEmpty) {
                      await _auth
                          .signInWithEmailAndPassword(
                              email: userModel.email!,
                              password: prevPassword.text)
                          .then((value) {
                        print("Buraya geldi");
                        FirebaseAuth.instance.currentUser!
                            .updatePassword(newPassword.text);
                        print("şifre başarılı*************");
                        Fluttertoast.showToast(msg: "Şifre başarılı ");
                      }).catchError((err) {
                        return Fluttertoast.showToast(msg: "Eski şifre yanlış");
                      });
                    }
                    statusService.updateProfile(userModel);
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: updateButton(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectProfileImage(ImageSource source,
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
          quality: 5,
        );
        setState(() {
          profileImage = XFile(compressedFile.path);
          print("dosyaya geldim: $profileImage");
          if (profileImage != null) {}
        });
        print('aaa');
      }
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Image Error: " + _pickImage);
      });
    }
  }

  void _selectBackgroundImage(ImageSource source,
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
          quality: 5,
        );
        setState(() {
          backgroundImage = XFile(compressedFile.path);
          print("dosyaya geldim: $profileImage");
          if (backgroundImage != null) {}
        });
        print('aaa');
      }
    } catch (e) {
      setState(() {
        _pickImage2 = e;
        print("Image Error: " + _pickImage2);
      });
    }
  }

  var _isLoading = false;

  Widget updateButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 216, 216, 216),
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Güncelle",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            _isLoading
                ? Center(
                    child: Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
