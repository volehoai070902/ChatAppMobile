import 'package:flutter/material.dart';

class PasswordFielddWidget extends StatefulWidget {
  final passTextController;
  const PasswordFielddWidget({
    super.key,
    required this.passTextController
  });

  @override
  State<PasswordFielddWidget> createState() => _PasswordFielddWidgetState();
}

class _PasswordFielddWidgetState extends State<PasswordFielddWidget> {
  bool passwordVisible = false;
  
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passTextController,
      obscureText: passwordVisible,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide:
                  BorderSide(color: Colors.black, style: BorderStyle.solid)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          hintText: "Password",
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            icon:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          )),
    );
  }
}