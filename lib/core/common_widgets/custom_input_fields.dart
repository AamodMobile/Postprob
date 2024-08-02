
import 'package:postprob/constants/constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  Widget? leading;
  Widget? leading1;
  TextCapitalization? textCapitalization;
  Widget? trailing;
  double? inputLabelWidth;
  double? inputFieldWidth;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  List<String> options; //If user want to show a searchable dropdown
  bool isRequired;
  TextInputType? txKeyboardType;
  bool isEnabled;
  FocusNode? focusNode;
  bool isFocused;
  bool? obscureText;
  bool check;
  bool checking;
  bool changeColor;
  bool? readOnly;
  String? labelText;
  Widget? labelWidget;
  String? labelText1;
  void Function(String)? onChanged;
  Function(String?)? onSaved;
  int maxCheck;
  int? maxLength;
  double? borderRadius;
  Color? borderCl;
  Color? fillColor;
  final void Function(String)? onFieldSubmitted;
  Function()? onEditingComplete;
  Function()? onTap;
  final ValueChanged<String>? onOptionSelection;

  CustomTextField({
    super.key,
    this.readOnly,
    this.hintText = "",
    this.maxCheck = 1,
    this.maxLength,
    this.leading,
    this.leading1,
    this.trailing,
    this.controller,
    this.labelText,
    this.labelText1,
    this.labelWidget,
    this.options = const [],
    this.inputFormatters,
    this.onTap,
    this.isRequired = false,
    this.onChanged,
    this.checking = false,
    this.inputLabelWidth,
    this.inputFieldWidth,
    this.isEnabled = true,
    this.txKeyboardType,
    this.obscureText,
    this.validator,
    this.focusNode,
    this.check = false,
    this.isFocused = false,
    this.onSaved,
    this.changeColor = false,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onOptionSelection,
    this.textCapitalization,
    this.borderCl,
    this.fillColor,
    this.borderRadius,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showdropdown = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.focusNode != null) {
      widget.focusNode!.removeListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    setState(() {
      showdropdown = widget.focusNode!.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700,color: Color(0xFF0D0140)),
          ),
        if (widget.labelText != null) const SizedBox(height: 6),
        if (widget.labelWidget != null) widget.labelWidget!,
        if (widget.labelWidget != null) const SizedBox(height: 10),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(153, 171, 198, 0.18),
                offset: Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 62
              )
            ]
          ),
          child: TextFormField(
            readOnly: widget.readOnly ?? false,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            controller: widget.controller,
            focusNode: widget.focusNode,
            autofocus: widget.isFocused,
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            keyboardType: widget.txKeyboardType ?? TextInputType.name,
            obscureText: widget.obscureText ?? false,
            enabled: widget.isEnabled,
            maxLines: widget.maxCheck,
            maxLength: widget.maxLength,
            onTap: widget.onTap,
            style: const TextStyle(
              color: blackCl,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              counterText: "",
              fillColor: widget.fillColor ?? Colors.white,
              filled: true,
              errorStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                fontFamily: regular,
                color: Colors.red,
              ),
              labelText: widget.labelText1,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                fontFamily: regular,
                color: const Color(0xFF3A3838),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                borderSide: BorderSide(
                  color: widget.borderCl ?? Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                borderSide: BorderSide(
                  color: widget.borderCl ??  Colors.white,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                borderSide: BorderSide(
                  color: widget.borderCl ?? Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                borderSide: BorderSide(
                  color: widget.borderCl ??  Colors.white,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 14.sp, color: hintColor, fontWeight: FontWeight.w400, fontFamily: regular),
              isDense: true,
              suffixIcon: widget.leading1 == null ? null : Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: widget.leading1!),
              suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon: widget.leading == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: widget.leading,
                    ),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            ),
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
          ),
        ),
        if (widget.focusNode != null && widget.options.isNotEmpty && showdropdown) const SizedBox(height: 8),
        if (widget.focusNode != null && widget.options.isNotEmpty && showdropdown)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 0.5,
                color: Colors.white,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(115, 115, 115, 0.33),
                  blurRadius: 18,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                ...widget.options.map(
                  (e) => InkWell(
                    onTap: () {
                      if (widget.controller != null) {
                        widget.controller!.text = e;
                        if (widget.onOptionSelection != null) {
                          widget.onOptionSelection!(e);
                        }
                      }
                      widget.focusNode!.unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: Row(
                        children: [
                          Text(e),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}

class CustomDateField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final double? inputLabelWidth;
  final double? inputFieldWidth;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final List<String> options; //If user want to show a searchable dropdown
  final bool isRequired;
  final  TextInputType? txKeyboardType;
  final  bool isEnabled;
  final  FocusNode? focusNode;
  final  bool isFocused;
  final  bool? obscureText;
  final bool check;
  final bool checking;
  final  bool changeColor;
  final String labelText;
  final void Function(String)? onChanged;
  final  Function(String?)? onSaved;
  final int maxCheck;
  final void Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final  Function()? onTap;

  const CustomDateField({
    super.key,
    this.hintText = "",
    this.maxCheck = 1,
    this.controller,
    this.labelText = "",
    this.options = const [],
    this.inputFormatters,
    this.onTap,
    this.isRequired = false,
    this.onChanged,
    this.checking = false,
    this.inputLabelWidth,
    this.inputFieldWidth,
    this.isEnabled = true,
    this.txKeyboardType,
    this.obscureText,
    this.validator,
    this.focusNode,
    this.check = false,
    this.isFocused = false,
    this.onSaved,
    this.changeColor = false,
    this.onFieldSubmitted,
    this.onEditingComplete,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: widget.onTap,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            autofocus: widget.isFocused,
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            keyboardType: widget.txKeyboardType ?? TextInputType.name,
            obscureText: widget.obscureText ?? false,
            enabled: widget.isEnabled,
            maxLines: widget.maxCheck,
            style: const TextStyle(
              color: mainColor,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              suffixIcon: const Icon(
                Icons.calendar_month,
                color: mainColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: mainColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: mainColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: mainColor,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: mainColor.withOpacity(0.25),
              ),
            ),
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
          ),
        ),
      ],
    );
  }
}
