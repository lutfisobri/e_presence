import 'package:flutter/material.dart';

class WidgetTextField extends StatefulWidget {
  WidgetTextField({
    Key? key,
    this.controller,
    this.obscure = false,
    this.focusNode,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.sufixIcon1,
    this.sufixIcon2,
    this.contenH = 0,
    this.contenV = 10,
    this.type,
    this.border,
    this.enable = true,
    this.fillColor,
    this.filled,
    this.hintStyle,
    this.style,
    this.enableBorder,
    this.disableBorder,
    this.focusColor,
    this.initialValue,
    this.focusBorder,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  final bool obscure;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, initialValue;
  final Widget? label, prefixIcon, sufixIcon1, sufixIcon2;
  final double contenH, contenV;
  final TextInputType? type;
  final OutlineInputBorder? border;
  final bool? enable, filled, readOnly;
  final Color? fillColor, focusColor;
  final TextStyle? hintStyle, style;
  final InputBorder? enableBorder, disableBorder, focusBorder;
  final void Function()? onTap;

  @override
  State<WidgetTextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<WidgetTextField> {
  bool obscure = true;
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        focusedBorder: widget.focusBorder,
        enabledBorder: widget.enableBorder,
        disabledBorder: widget.disableBorder,
        focusColor: widget.focusColor,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        suffixIcon: widget.obscure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: obscure ? widget.sufixIcon1 : widget.sufixIcon2,
              )
            : widget.sufixIcon1,
            suffixIconColor: Colors.black,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.contenH,
          vertical: widget.contenV,
        ),
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: widget.border,
      ),
      obscureText: widget.obscure ? obscure : widget.obscure,
      controller: widget.controller,
      enabled: widget.enable,
      style: widget.style,
      onTap: widget.onTap,
      readOnly: widget.readOnly! ? widget.readOnly! : readOnly,
    );
  }
}
