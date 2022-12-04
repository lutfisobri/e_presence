import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.onPres,
    required this.child,
    this.bgColor,
    this.fgColor,
    this.elevation,
    this.shape,
    this.textStyle,
    this.focusNode,
    this.minimunSize,
  });

  final void Function()? onPres;
  final Widget child;
  final Color? bgColor;
  final Color? fgColor;
  final double? elevation;
  final RoundedRectangleBorder? shape;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final Size? minimunSize;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPres,
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(widget.minimunSize),
        backgroundColor: MaterialStatePropertyAll(widget.bgColor),
        foregroundColor: MaterialStatePropertyAll(widget.fgColor),
        elevation: MaterialStatePropertyAll(widget.elevation),
        shape: MaterialStatePropertyAll(widget.shape),
        textStyle: MaterialStatePropertyAll(widget.textStyle),
      ),
      focusNode: widget.focusNode,
      child: widget.child,
    );
  }
}
