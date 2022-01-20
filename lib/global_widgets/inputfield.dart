import 'package:flutter/material.dart';

class EmailInputFieldFb3 extends StatelessWidget {
  final TextEditingController inputController;
  final Icon icon;
  final String hint;
  final TextInputType inputStyle;
  final bool isObscure;

  const EmailInputFieldFb3({
    Key? key,
    required this.inputController,
    required this.icon,
    required this.hint,
    required this.inputStyle,
    required this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        obscureText: isObscure,
        controller: inputController,
        onChanged: (value) {},
        keyboardType: inputStyle,
        style: const TextStyle(fontSize: 14, color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: icon,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
