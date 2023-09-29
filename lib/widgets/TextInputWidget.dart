import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  TextEditingController ?controller;
  String hintText;
  bool readOnly;
  bool ?autofocus;
  String? Function(String?)? validator;
  TextInputWidget({
    Key? key,
     this.controller,
    required this.hintText,
   required  this.readOnly,
     this.autofocus,
    this.validator,
  }) : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8
      ),
      child: TextFormField(
        
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
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
        readOnly: widget.readOnly,
        autofocus: widget.autofocus==null?false:widget.autofocus! ,
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
