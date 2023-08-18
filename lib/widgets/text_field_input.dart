import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final bool isSearch;
  final String hintText;
  final String iconPath;
  final TextInputType textInputType;
  final String? Function(String?)? validator; // Added validator function
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    this.isSearch = false,
    required this.hintText,
    required this.textInputType,
    required this.iconPath,
    this.validator, // Added validator
  }) : super(key: key);

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(40));

    return TextFormField(
      // Using TextFormField to integrate with validator
      controller: widget.textEditingController,
      validator: widget.validator, // Assigning the validator function
      decoration: InputDecoration(
        suffixIcon: widget.isSearch
            ? const SizedBox()
            : widget.isPass
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(widget.iconPath),
                  ),
        prefixIcon: widget.isSearch
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(widget.iconPath),
              )
            : const SizedBox(),
        hintText: widget.hintText,
        fillColor: Colors.white,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 20, vertical: widget.isSearch ? 12 : 25),
      ),
      keyboardType: widget.textInputType,
      obscureText:
          widget.isPass && !_showPassword, // Toggle password visibility
    );
  }
}
