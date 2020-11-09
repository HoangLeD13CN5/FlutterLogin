import 'package:flutter/material.dart';

class CustomShapeClipLogin extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height - 70);
    
    var firstEndPoint = Offset(size.width * 0.5, size.height - 30);
    var firstControlPoint = Offset(size.width * 0.25, size.height- 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width , size.height - 50);
    var secondControlPoint = Offset(size.width * 0.75, size.height- 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<dynamic> oldClipper) => true;

}

class CustomShapeClipLogin2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstEndPoint = Offset(size.width * 0.5, size.height - 50);
    var firstControllerPoint = Offset(size.width * 0.25, size.height - 30);
    path.quadraticBezierTo(firstControllerPoint.dx, firstControllerPoint.dy, firstEndPoint.dx , firstEndPoint.dy);

    var secondEndPoint = Offset(size.width , size.height - 5);
    var secondControllerPoint = Offset(size.width * 0.75, size.height - 20);
    path.quadraticBezierTo(secondControllerPoint.dx, secondControllerPoint.dy, secondEndPoint.dx , secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

}