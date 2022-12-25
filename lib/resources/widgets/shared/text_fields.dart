import 'package:flutter/material.dart';

class WtextField extends StatefulWidget {
  const WtextField({
    super.key,
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
    this.primaryColor,
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
    this.validator,
    this.maxlenght,
    this.onChanged,
    this.textalign = TextAlign.start,
    this.counterText,
    this.errorStyle,
    this.errorBorder,
    this.autovalidateMode,
    this.autofillHints,
  });

  final bool obscure;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, initialValue, counterText;
  final Widget? label, prefixIcon, sufixIcon1, sufixIcon2;
  final double contenH, contenV;
  final TextInputType? type;
  final OutlineInputBorder? border;
  final bool? enable, filled, readOnly;
  final Color? fillColor, focusColor, primaryColor;
  final TextStyle? hintStyle, style, errorStyle;
  final InputBorder? enableBorder, disableBorder, focusBorder, errorBorder;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final int? maxlenght;
  final void Function(String)? onChanged;
  final TextAlign textalign;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;

  @override
  State<WtextField> createState() => _WtextFieldState();
}

class _WtextFieldState extends State<WtextField> {
    bool obscure = true;
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: widget.primaryColor),
      ),
      child: TextFormField(
        maxLength: widget.maxlenght,
        textAlign: widget.textalign,
        keyboardType: widget.type,
        autovalidateMode: widget.autovalidateMode,
        initialValue: widget.initialValue,
        validator: widget.validator,
        onChanged: widget.onChanged,
        autofillHints: widget.autofillHints,
        decoration: InputDecoration(
          errorStyle: widget.errorStyle,
          errorBorder: widget.errorBorder,
          counterText: widget.counterText,
          focusedBorder: widget.focusBorder,
          label: widget.label,
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
      ),
    );
  }
}
