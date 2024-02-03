import 'package:flutter/material.dart';

class MakingText extends StatelessWidget {
  const MakingText(this.text, {super.key});

  //final Color colors;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text, //.copyWith(color: colors),
    );
  }
}
