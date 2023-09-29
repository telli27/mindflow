import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget showIcon({required int index}) {
  Color color = Colors.black;
  if (index == 0) {
    return FaIcon(
      FontAwesomeIcons.newspaper,color: color,
      size: 30,
    );
  } else if (index == 1) {
    return FaIcon(
      FontAwesomeIcons.book,
      color: color,
      size: 30,
    );
  } else if (index == 2) {
    return FaIcon(
      FontAwesomeIcons.atom,
      color: color,
      size: 30,
    );
  } else if (index == 3) {
    return FaIcon(
      FontAwesomeIcons.music,
      color: color,
      size: 30,
    );
  } else if (index == 4) {
    return FaIcon(
      FontAwesomeIcons.mobile,
      color: color,
      size: 30,
    );
  } else if (index == 5) {
    return FaIcon(
      FontAwesomeIcons.television,
      color: color,
      size: 30,
    );
  } else if (index == 6) {
    return FaIcon(
      FontAwesomeIcons.code,
      color: color,
      size: 30,
    );
  } else {
    return FaIcon(
      FontAwesomeIcons.globe,
      color: color,
      size: 30,
    );
  }
}
