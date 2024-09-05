import 'package:flutter/material.dart';

class UpLoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, .8 * h);

    path.quadraticBezierTo(1 / 6 * w, h, 1 / 3 * w, .75 * h);
    path.quadraticBezierTo(.5 * w, .5 * h, 2 / 3 * w, .8 * h);

    path.quadraticBezierTo(5 / 6 * w, h, w, .2 * h);

    path.lineTo(w, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class UpRegisterClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, 0);

    path.quadraticBezierTo(1 / 6 * w, h, 1 / 3 * w, .75 * h);
    path.quadraticBezierTo(.5 * w, .5 * h, 2 / 3 * w, .75 * h);

    path.quadraticBezierTo(5 / 6 * w, h, w, .8 * h);

    path.lineTo(w, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class UpdateAccountClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, .75 * h);

    path.quadraticBezierTo(
      .25 * w,
      h,
      .5 * w,
      .75 * h,
    );
    path.quadraticBezierTo(
      .75 * w,
      .5 * h,
      w,
      .75 * h,
    );

    path.lineTo(w, h);
    path.lineTo(0, h);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
} // wait to use for auth screens

class DownAccountClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, .25 * h);

    path.quadraticBezierTo(
      .25 * w,
      h,
      .5 * w,
      .75 * h,
    );
    path.quadraticBezierTo(
      .75 * w,
      .5 * h,
      w,
      .75 * h,
    );

    path.lineTo(w, h);
    path.lineTo(0, h);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class DownChangePasswordClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.lineTo(0, h);

    path.cubicTo(
      .25 * w,
      .1 * h,
      .5 * w,
      .95 * h,
      w,
      0,
    );

    path.lineTo(w, h);
    path.lineTo(0, h);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
