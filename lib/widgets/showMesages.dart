import 'package:mindflow/config/appConfig.dart';
import 'package:flutter/material.dart';

void showMessage(String message) {
  // Burada bir mesajı kullanıcıya göstermek için bir yöntem kullanabilirsiniz.
  // Örneğin, bir SnackBar veya AlertDialog kullanabilirsiniz.
  // Aşağıda bir SnackBar kullanımı örneklenmiştir:

  final snackBar = SnackBar(
    content: Text(message),
  );

  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // Yukarıdaki satırın çalışması için bu işlemi bir MaterialApp içinde kullanmalısınız.
}

Widget CustomPreviewPadding(context, name, value) => Row(
      children: [
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width * 0.22,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      :AppConfig.appColor),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.72,
          height: 49,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: value,
            ),
          ),
        ),
      ],
    );

Widget CustomTextAreaPreviewMySkillsPadding(context, name, value) => Row(
      children: [
        Container(
          height: 49,
    width: MediaQuery.of(context).size.width * 0.22,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppConfig.appColor),
            ),
          ),
        ),
        Container(
           width: MediaQuery.of(context).size.width * 0.72,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Padding(
            padding: EdgeInsets.only(left: 0,top: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child:value
            ),
          ),
        ),
      ],
    );

