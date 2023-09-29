import 'package:flutter/material.dart';

Widget CustomPreview(context, name, value) => Row(
      children: [
        Container(
          height: 49,
          width: MediaQuery.of(context).size.width * 0.2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.70,
          height: 49,
          decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value.toString(),
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
Widget CustomPreviewDetail(context, name, value) => Row(
      children: [
        Container(
          height: 49,
          width: MediaQuery.of(context).size.width * 0.2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.70,
         // height: 49,
          decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: value
              ),
            ),
          ),
        ),
      ],
    );
