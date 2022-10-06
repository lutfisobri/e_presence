import 'package:flutter/material.dart';

class WidgetTextField extends StatefulWidget {
  const WidgetTextField({
    Key? key,
    required this.controller,
    this.obscure = false,
    this.focusNode,
    this.hintText,
    this.prefixIcon,
    this.sufixIcon1,
    this.sufixIcon2,
    this.contenH = 10,
    this.contenV = 10,
    this.type,
    this.border,
    this.enable = true,
  }) : super(key: key);

  final bool obscure;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon1;
  final Widget? sufixIcon2;
  final double contenH;
  final double contenV;
  final TextInputType? type;
  final OutlineInputBorder? border;
  final bool enable;

  @override
  State<WidgetTextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<WidgetTextField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      obscureText: widget.obscure ? obscure : widget.obscure,
      controller: widget.controller,
      enabled: widget.enable,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        suffixIcon: widget.obscure ? GestureDetector(
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
          child: obscure ? widget.sufixIcon1 : widget.sufixIcon2,
        ) : widget.sufixIcon1,
        // suffixIcon: widget.sufixIcon1,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.contenH,
          vertical: widget.contenV,
        ),
        border: widget.border,
      ),
    );
  }
}
