import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;
  final bool isDense;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.initialValue,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autovalidateMode,
    this.errorText,
    this.isDense = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: isDense,
        errorStyle: AppTypography.caption.copyWith(
          color: AppColors.error,
        ),
      ),
      style: AppTypography.bodyLarge,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: autovalidateMode,
    );
  }
}
