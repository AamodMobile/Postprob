
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';

enum CustomButtonStyle { style1, style2, style3, custom }

class CustomButtonWidget extends StatelessWidget {
  final CustomButtonStyle style;
  final Function onPressed;
  final String text;
  final Widget? content;
  final Widget? iconWidget;
  final bool enabled;
  final EdgeInsets padding;
  final bool? iconAlignRight;
  final double? width;
  final double? radius;

  const CustomButtonWidget({
    super.key,
    this.style = CustomButtonStyle.style1,
    required this.onPressed,
    required this.text,
    this.width,
    this.content,
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.iconWidget,
    this.iconAlignRight, this.radius,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case CustomButtonStyle.style1:
        return InkWell(
          onTap: enabled
              ? () {
                  onPressed();
                }
              : null,
          child: Container(
            width: width ?? MediaQuery.of(context).size.width,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius??6),
              color: enabled ? mainColor : mainColor,
            ),
            child: Center(
              child:  iconWidget != null
                  ? ((iconAlignRight ?? false)
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: enabled ? Colors.white : Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  iconWidget!,
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWidget!,
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: TextStyle(fontSize: 14.sp, fontFamily: regular, color: enabled ? Colors.white : mainColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ))
                  : Text(
                text,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      case CustomButtonStyle.style2:
        return InkWell(
          onTap: enabled
              ? () {
                  onPressed();
                }
              : null,
          child: Container(
            width: width ?? MediaQuery.of(context).size.width,
            padding: padding,
            decoration: BoxDecoration(
              color:  const Color(0xFFD6CDFE),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,4),
                  blurRadius: 62,
                  spreadRadius: 0,
                  color: Color.fromRGBO(153, 171, 198, 0.18)
                )
              ],
              border: Border.all(
                color:  Colors.transparent,
              ),
            ),
            child: Center(
              child: iconWidget != null
                  ? ((iconAlignRight ?? false)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: TextStyle(color: enabled ? const Color(0xFF130160) : const Color(0xFF130160), fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            iconWidget!,
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconWidget!,
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              text,
                              style: TextStyle(fontSize: 14.sp, fontFamily: regular, color: enabled ? const Color(0xFF130160) : const Color(0xFF130160), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ))
                  : Text(
                      text,
                      style: TextStyle(
                        color: enabled ? const Color(0xFF130160) : const Color(0xFF130160),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        );
      case CustomButtonStyle.style3:
        return InkWell(
          onTap: enabled
              ? () {
                  onPressed();
                }
              : null,
          child: Container(
            width: width ?? MediaQuery.of(context).size.width,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: enabled ? mainColor : mainColor,
              ),
            ),
            child: Center(
              child: iconWidget != null
                  ? ((iconAlignRight ?? false)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: TextStyle(color: enabled ? mainColor : mainColor, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            iconWidget!,
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconWidget!,
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              text,
                              style: TextStyle(fontSize: 14.sp, fontFamily: regular, color: enabled ? mainColor : mainColor, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))
                  : Text(
                      text,
                      style: TextStyle(color: enabled ? blackCl : mainColor, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        );
      default:
        return InkWell(
          onTap: enabled
              ? () {
                  onPressed();
                }
              : null,
          child: Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: enabled ? mainColor : mainColor,
              ),
              child: content),
        );
    }
  }

  Color mixColors(Color color1, Color color2, double factor) {
    return Color.lerp(color1, color2, factor)!;
  }
}
