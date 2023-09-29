import 'package:flutter/material.dart';

import 'package:mindflow/config/appConfig.dart';

class InkWellButton extends StatefulWidget {
  String buttonTitle;
  VoidCallback onTap;
  Widget? indicatorWidget;
  InkWellButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
    this.indicatorWidget,
  }) : super(key: key);

  @override
  State<InkWellButton> createState() => _InkWellButtonState();
}

class _InkWellButtonState extends State<InkWellButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
          decoration: BoxDecoration(
              color: AppConfig.appColor,
              borderRadius: BorderRadius.circular(6)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Text(
                  widget.buttonTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                if (widget.indicatorWidget == null) ...{
                  Container()
                } else ...{
                  SizedBox(
                    width: 20,
                  ),
                  widget.indicatorWidget!,
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
