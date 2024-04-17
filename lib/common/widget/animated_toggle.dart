import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/themeService.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      height: Get.width * 0.12,
      // margin: EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition;
              var index = 0;
              if (!initialPosition) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: Get.width * 0.5,
              height: Get.width * 0.12,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.width * 0.1),
                  side: BorderSide(color: ThemeService.primaryColor.withOpacity(0.5))
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                      (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: ThemeService.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
            initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: Get.width * 0.29,
              height: Get.width * 0.12,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.width * 0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                initialPosition ? widget.values[0] : widget.values[1],
                style: TextStyle(
                  fontSize: Get.width * 0.045,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}