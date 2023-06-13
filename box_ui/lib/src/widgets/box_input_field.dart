import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BoxInputField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final void Function()? trailingTapped;
  final String? Function(String?)? validator;
  final bool error;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyBoardType;
  final int? maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final bool dismissKeyboard;

  const BoxInputField(
      {Key? key,
      required this.controller,
      this.placeholder = '',
      this.leading,
      this.trailing,
      this.trailingTapped,
      this.password = false,
      this.validator,
      this.error = false,
      this.inputFormatters,
      this.keyBoardType,
      this.maxLines = 1,
      this.maxLength, this.onTap, this.dismissKeyboard=false})
      : super(key: key);

  @override
  State<BoxInputField> createState() => _BoxInputFieldState();
}

class _BoxInputFieldState extends State<BoxInputField> {
  final circularBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(4));
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection:  !widget.dismissKeyboard,
      onTap: widget.dismissKeyboard?(){
        _focusNode.unfocus();
        widget.onTap?.call();}:widget.onTap,
      textAlignVertical: TextAlignVertical.center,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyBoardType,
      focusNode: _focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: appPrimaryColor,
      controller: widget.controller,
      style: const TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
      obscureText: widget.password,
      validator: widget.validator,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
          hintStyle: const TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: appHintColor),
          hintText: widget.placeholder,
          contentPadding: EdgeInsets.zero,
          filled: true,
          focusColor: Colors.transparent,
          prefixIcon: widget.leading,
          prefixIconColor: appPrimaryColor,
          suffixIcon: widget.trailing != null ? GestureDetector(onTap: widget.trailingTapped, child: widget.trailing) : null,
          border: circularBorder.copyWith(borderSide: const BorderSide(color: Color(0xffE5E5E5), width: 1)),
          enabledBorder: circularBorder.copyWith(borderSide: const BorderSide(color: Color(0xffE5E5E5), width: 1)),
          focusedBorder: circularBorder.copyWith(borderSide: const BorderSide(color: appPrimaryColor, width: 1)),
        errorBorder: circularBorder.copyWith(borderSide: const BorderSide(color: Colors.red, width: 1)),
        focusedErrorBorder: circularBorder.copyWith(borderSide: const BorderSide(color: Colors.red, width: 1)),

          ),
    );
  }
}
