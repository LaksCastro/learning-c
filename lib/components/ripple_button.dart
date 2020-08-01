import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final Color color;

  RippleButton({this.onTap, this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(5)),
              child: Material(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(label,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
                color: Colors.transparent,
              ),
            )));
  }
}
