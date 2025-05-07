import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme/style.dart';

class ProfileTextField extends StatefulWidget {
  final String hintText;
  final String? initialValue;
  final bool isEditable;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;

  const ProfileTextField({
    super.key,
    required this.hintText,
    this.initialValue,
    this.isEditable = true,
    this.isPassword = false,
    this.onChanged,
    this.validator,
    this.onTap,
  });

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    if(widget.onTap != null){
      _focusNode.canRequestFocus = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  String? _validateUsername(String? value){
    if(value == null || value.trim().isEmpty){
      return "Please enter a username";
    }
    const usernamePattern = r'^[a-zA-Z\s-]+$';
    final regex = RegExp(usernamePattern);
    if(!regex.hasMatch(value.trim())){
      return 'Username must contain only letters, spaces, or hyphens';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: TextFormField(
          controller: _controller,
          onChanged: widget.onChanged,
          enabled: widget.isEditable && widget.onTap == null,
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          style: GoogleFonts.comfortaa(color: textColor, fontSize: 20),
          cursorColor: Colors.white,
          cursorOpacityAnimates: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.comfortaa(
              color: secondaryTextColor,
              fontSize: 20,
            ),
            filled: true,
            fillColor: appBarColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 3, color: sendMessageColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 3, color: sendMessageColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 3, color: sendMessageColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 3, color: sendMessageColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 3, color: Colors.red),
            ),
            errorStyle: GoogleFonts.comfortaa(color: Colors.red, fontSize: 12),
            errorMaxLines: 2,
          ),
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          validator: widget.validator ?? (widget.isEditable && !widget.isPassword ? _validateUsername : null),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}
