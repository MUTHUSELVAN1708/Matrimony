import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final bool? isEnabled;
  final bool filled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? borderColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final bool showCursor;
  final AutovalidateMode? autovalidateMode;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final bool expands;
  final VoidCallback? onTap;
  final bool autofocus;
  final String? counterText;
  final bool enableSuggestions;
  final bool autocorrect;

  const CustomTextFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.isEnabled,
    this.filled = false,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onSaved,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.isDense,
    this.contentPadding,
    this.fillColor,
    this.cursorColor,
    this.borderColor,
    this.borderRadius,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.showCursor = true,
    this.autovalidateMode,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.textAlignVertical,
    this.textAlign = TextAlign.start,
    this.expands = false,
    this.onTap,
    this.autofocus = false,
    this.counterText,
    this.enableSuggestions = true,
    this.autocorrect = true,
  });

  Widget? _getDefaultPrefixIcon() {
    if (hintText == null) return null;

    if (hintText!.toLowerCase().contains('email')) {
      return const Icon(Icons.email, color: Colors.grey);
    } else if (hintText!.toLowerCase().contains('contact') ||
        hintText!.toLowerCase().contains('phone')) {
      return const Icon(Icons.phone, color: Colors.grey);
    } else if (hintText!.toLowerCase().contains('password')) {
      return const Icon(Icons.lock, color: Colors.grey);
    } else if (hintText!.toLowerCase().contains('search')) {
      return const Icon(Icons.search, color: Colors.grey);
    } else if (hintText!.toLowerCase().contains('name')) {
      return const Icon(Icons.person, color: Colors.grey);
    } else if (hintText!.toLowerCase().contains('date')) {
      return const Icon(Icons.calendar_today, color: Colors.grey);
    }
    return null;
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      borderSide: BorderSide(
        color: color,
        width: color == Colors.transparent ? 0 : 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController effectiveController =
        controller ?? TextEditingController(text: initialValue);

    return Padding(
      padding: isEnabled ?? true
          ? const EdgeInsets.only(bottom: 8.0)
          : EdgeInsets.zero,
      child: TextFormField(
        controller: effectiveController,
        enabled: isEnabled,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onSubmitted,
        onSaved: onSaved != null ? (value) => onSaved!(value ?? '') : null,
        validator: validator,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        expands: expands,
        autofocus: autofocus,
        onTap: onTap,
        showCursor: showCursor,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        style: textStyle ?? const TextStyle(color: Colors.black),
        // decoration: InputDecoration(
        //   hintText: hintText,
        //   labelText: labelText,
        //   errorText: errorText,
        //   filled: true,
        //   isDense: isDense,
        //   fillColor: fillColor ?? Colors.white,
        //   contentPadding: contentPadding ??
        //       const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        //   hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
        //   labelStyle: labelStyle,
        //   errorStyle: errorStyle,
        //   counterText: counterText,
        //   prefix: prefix,
        //   suffix: suffix,
        //   prefixIcon: prefixIcon ?? _getDefaultPrefixIcon(),
        //   suffixIcon: suffixIcon,
        //   prefixIconConstraints: prefixIconConstraints,
        //   suffixIconConstraints: suffixIconConstraints,
        //   enabledBorder: _buildBorder(borderColor ?? Colors.transparent),
        //   disabledBorder: _buildBorder(Colors.transparent),
        //   focusedBorder: _buildBorder(borderColor ?? Colors.red),
        //   errorBorder: _buildBorder(Colors.red),
        //   focusedErrorBorder: _buildBorder(Colors.red),
        // ),
        decoration: InputDecoration(
          hintText: hintText,
          filled: filled,
          fillColor: fillColor ?? Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: _getDefaultPrefixIcon(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        autovalidateMode: autovalidateMode,
      ),
    );
  }
}
