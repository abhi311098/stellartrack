import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/const/color_const.dart';

class TextDesign extends StatelessWidget {

  String? text;
  double? fontSize;
  int? maxLines;
  Color? color;
  FontWeight? fontWeight;
  TextDesign({Key? key, required this.text, this.fontSize, this.fontWeight, this.maxLines, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text!, textScaleFactor: 0.85,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 100,
      style: GoogleFonts.lato(
       color: color ?? colorBlack,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 16,
    ),);
  }
}
