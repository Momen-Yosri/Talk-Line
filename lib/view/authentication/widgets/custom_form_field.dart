import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/app_colors.dart';
class CustomTextFormField extends StatelessWidget {
  String label;
  String hint;
  TextInputType keyboardType = TextInputType.text;
  bool isTextObscured = false;
  bool isPassword = false;
  String? Function(String?) validator;
  TextEditingController controller;

  CustomTextFormField(
      {super.key,
      required this.label,
      required this.hint,
      this.keyboardType = TextInputType.text,
      this.isTextObscured = false,
      this.isPassword = false,
      required this.validator,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        
          hintText: hint,
          label: Text(
            label,
          ),
          labelStyle: TextStyle(color: AppColors.primaryColor, fontSize: 12.sp),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
          border: OutlineInputBorder(),
          suffixIcon: isPassword
              ? IconButton(
                  icon:  Icon(Icons.visibility_off_outlined), onPressed: () {})
              : null),
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ?true: isTextObscured,
    );
  }
}
