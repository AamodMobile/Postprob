


import 'package:postprob/constants/constants.dart';

class SmallTexts extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final int? maxline;

  const SmallTexts(
      {super.key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 10.0,
      this.height = 0.2,
      this.maxline});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: size,
          fontStyle: FontStyle.normal,
          fontFamily: regular,
          color: color),
    );
  }
}
