import 'package:flutter/material.dart';

class WidgetEleBtn extends StatefulWidget {
  const WidgetEleBtn({
    required this.onPres,
    required this.child,
    this.bgColor,
    this.fgColor,
    this.elevation,
    this.shape,
    this.textStyle,
    this.focusNode,
  });

  final void Function()? onPres;
  final Widget child;
  final Color? bgColor;
  final Color? fgColor;
  final double? elevation;
  final RoundedRectangleBorder? shape;
  final TextStyle? textStyle;
  final FocusNode? focusNode;

  @override
  State<WidgetEleBtn> createState() => _WidgetEleBtnState();
}

class _WidgetEleBtnState extends State<WidgetEleBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPres,
      style: ButtonStyle(
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
