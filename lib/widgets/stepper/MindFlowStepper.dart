import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int activeCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stepper widget"),
      ),
      body: Column(
        children: [
          Expanded(
            child: MindFlowStepper(
                onChange: (value) {
                  activeCurrentIndex = value;
                },
                items: [
                  MindFlowItem(
                      icon: Icons.home, title: "Yetenekler"),
                  MindFlowItem(icon: Icons.search, title: "Keşfet"),
                  MindFlowItem(icon: Icons.home, title: "Ayarlar")
                ],
                activeCurrentIndex: activeCurrentIndex),
          ),
        ],
      ),
      bottomNavigationBar: IconButton(
          onPressed: () {
            setState(() {
              activeCurrentIndex = activeCurrentIndex + 1;
            });
          },
          icon: Text("ileri")),
    );
  }
}

class MindFlowItem {
  IconData icon;
  String title;
  MindFlowItem({
    required this.icon,
    required this.title,
  });
}

class MindFlowStepper extends StatefulWidget {
  ValueChanged onChange;
  List<MindFlowItem> items;
  int activeCurrentIndex;
  MindFlowStepper({
    Key? key,
    required this.onChange,
    required this.items,
    required this.activeCurrentIndex,
  }) : super(key: key);
  @override
  State<MindFlowStepper> createState() => _MindFlowStepperState();
}

class _MindFlowStepperState extends State<MindFlowStepper> {
  void onChanged() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 120,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (widget.items.length > widget.activeCurrentIndex &&
                    widget.activeCurrentIndex != 0) {
                  widget.activeCurrentIndex -= 1;
                  setState(() {});
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                  right: 20,left: 5
                ),
                child: Container(
             
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.items.map((e) {
                      int index = widget.items.indexOf(e);
                      return Row(
                        children: [
                          Column(
                            children: [
                              CustomPaint(
                                painter: CirclePainter(
                                  color: index == widget.activeCurrentIndex
                                      ? Colors.orange
                                      : Colors.grey,
                                  isActive: index == widget.activeCurrentIndex
                                      ? true
                                      : false,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    e.icon,
                                    size: 20,
                                    color: index == widget.activeCurrentIndex
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 80,
                                child: Text(
                                  e.title,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (index < widget.items.length - 1) ...[
                            SizedBox(
                              width: 2,
                            ),
                            for (int j = 0;
                                j < 12;
                                j++) 
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 3, top: 20),
                                  child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 20,
                            ),
                          ]
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final bool isActive;

  CirclePainter({required this.color, required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = isActive ? 1.0 : 0.6; // Adjust the thickness as needed

    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double step = 2 * pi / 30;

    for (double theta = 0; theta < 2 * pi; theta += step) {
      double x1 = centerX + radius * cos(theta);
      double y1 = centerY + radius * sin(theta);
      double x2 = centerX + radius * cos(theta + step);
      double y2 = centerY + radius * sin(theta + step);

      // Draw a dotted line for all items
      double dotSpacing = 4.0; // Adjust the spacing between dots

      for (double d = 0; d < step; d += dotSpacing) {
        double t = d / step;
        double x = lerpDouble(x1, x2, t)!;
        double y = lerpDouble(y1, y2, t)!;
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color color;

  DashedDivider({
    this.height = 1.0,
    this.thickness = 1.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0; // Adjust the width of each dash
        final dashHeight = height; // Adjust the height of the dash

        int dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Flex(
          children: List.generate(dashCount, (index) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
