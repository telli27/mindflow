import 'package:mindflow/config/appConfig.dart';
import 'package:flutter/material.dart';

class TextPasswordInputWidget extends StatefulWidget {
  TextEditingController controller;
  String hintText;
    String? Function(String?)? validator;

  TextPasswordInputWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator
  }) : super(key: key);

  @override
  State<TextPasswordInputWidget> createState() =>
      _TextPasswordInputWidgetState();
}

class _TextPasswordInputWidgetState extends State<TextPasswordInputWidget> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText:    _obscureText,
        decoration: InputDecoration(
          
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppConfig.appColor),
          ),
          hintText: widget.hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 28.0, horizontal: 12.0),
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
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        onSaved: (value) {},
                 validator: widget.validator != null ? widget.validator : null,

      ),
    );
  }
}
