import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.action,
    this.focusNode,
    this.borderRadius,
  });
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final Widget? suffixIcon, prefixIcon, prefix;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (text) {
        widget.onChanged?.call(text);
      },
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      textInputAction: widget.action ?? TextInputAction.next,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: AppColor.darkGrayColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        errorMaxLines: 4,
        errorStyle: const TextStyle(color: AppColor.redColor),
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffixIcon: widget.suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        border: outlineInputBorder(color: Colors.grey, width: 1),
        enabledBorder: outlineInputBorder(color: Colors.grey, width: 1),
        focusedBorder: outlineInputBorder(color: Colors.black, width: 1),
        errorBorder: outlineInputBorder(color: Colors.red, width: 1),
        focusedErrorBorder: outlineInputBorder(color: Colors.red, width: 1),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent, width: width),
    );
  }
}
