import 'package:flutter/gestures.dart';
import 'package:postprob/constants/constants.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
      this.text, {
        super.key,
        this.trimLines = 2,
      });

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
      text: _readMore ? " ...Read more" : " Read less",
      style: TextStyle(
        color: yellowDark,
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
        fontStyle: FontStyle.normal,
        fontFamily: medium,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
          style:  TextStyle(
            color: smallTextCl,
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
            fontStyle: FontStyle.normal,
            fontFamily: regular,
          ),
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style:  TextStyle(
              color: smallTextCl,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
              fontStyle: FontStyle.normal,
              fontFamily: regular,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style:  TextStyle(
              color: smallTextCl,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
              fontStyle: FontStyle.normal,
              fontFamily: regular,
            ),
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}