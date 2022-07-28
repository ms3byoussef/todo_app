import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height = 56,
    this.width = double.infinity,
  }) : super(key: key);
  final String label;
  final Function() onPressed;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: primaryClr,
        ),
        onPressed: onPressed,
        child: Text(label, style: AppTheme.buttonText),
      ),
    );
  }
}
