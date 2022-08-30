import 'package:flutter/material.dart';

import '../utility/icon_util.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool? isNumber;
  final String emptyWarning;
  final String icon;
  final String labelText;
  final String hintText;

  const CustomTextField({Key? key,
    required this.textEditingController,
    this.isNumber,
    required this.emptyWarning,
    required this.hintText,
    required this.icon,
    required this.labelText
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      keyboardType: widget.isNumber == null ? TextInputType.text : TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.emptyWarning;
        }
        return null;
      },
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        hintText: widget.hintText,
        prefixIcon: Icon(IconUtil.getIconFromString(widget.icon)),
        labelText: widget.labelText,
      ),
    );
  }
}