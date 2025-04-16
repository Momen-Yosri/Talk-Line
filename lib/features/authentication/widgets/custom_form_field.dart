import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/core/style/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?) validator;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    required this.validator,
    required this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isTextObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hint,
        label: Text(widget.label),
        labelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 12.sp,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12.sp,
        ),
        border: const OutlineInputBorder(),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isTextObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _isTextObscured = !_isTextObscured;
                  });
                },
              )
            : null,
      ),
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _isTextObscured,
    );
  }
}