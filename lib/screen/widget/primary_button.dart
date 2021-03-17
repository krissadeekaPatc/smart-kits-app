import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final Border border;
  final double radius;

  PrimaryButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height,
    this.onPressed,
    this.border,
    this.radius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        border: border,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.white.withOpacity(0),
            highlightColor: Colors.white.withOpacity(0),
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
