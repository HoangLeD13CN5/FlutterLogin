
import 'package:flutter/material.dart';
import 'package:onepay_sign_auth_dart/ui/widgets/responsive_ui.dart';

class CustomTextFieldLogin extends StatelessWidget {
  double _width;
  double _height;
  double _pixelRatio;
  bool _large;
  bool _medium;

  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obscureText;

  CustomTextFieldLogin({this.hint, this.textEditingController, this.keyboardType, this.icon, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    return Material (
      elevation: _large ? 12 : (_medium ? 10 : 8),
      borderRadius: BorderRadius.circular(30.0),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: textEditingController,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: Colors.orange[200], size: 20),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none
          )
        ),
    ),
    );
  }
}