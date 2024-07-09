
import 'package:lottie/lottie.dart';
import 'package:postprob/constants/constants.dart';

class LoaderClass extends StatefulWidget {
  final double height;
  const LoaderClass({super.key, required this.height});

  @override
  State<LoaderClass> createState() => _LoaderClassState();
}

class _LoaderClassState extends State<LoaderClass> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width),
          Container(
            height: 200.h,width: 200.w,
            padding:  EdgeInsets.all(50.h),
            decoration: BoxDecoration(
              color: bgCl,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Lottie.asset(loadingJson,height: 200.h,width: 200.w,fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }
}
