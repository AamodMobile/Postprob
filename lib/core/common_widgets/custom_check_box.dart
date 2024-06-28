import 'package:postprob/constants/constants.dart';

class LabeledCheckbox extends StatelessWidget {
   LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
     this.color
  });

  final String label;
   Color? color;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: color??Color(0xFFE6E1FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: value
            ? Center(
                child: Icon(
                  Icons.done,
                  size: 18,
                  color: mainColor,
                ),
              )
            : const Opacity(
                opacity: 0.0,
                child: Icon(
                  Icons.account_circle,
                  size: 14,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
