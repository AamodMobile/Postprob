import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/dashboard/providers/dashboard_provider.dart';

class TabItemWidget extends StatefulWidget {
  final int index;
  final String iconPath;
  final DashboardProvider state;

  const TabItemWidget({super.key, required this.index, required this.iconPath, required this.state});

  @override
  State<TabItemWidget> createState() => _TabItemWidgetState();
}

class _TabItemWidgetState extends State<TabItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.state.onChangeBaseBottomIndex(widget.index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.index==2?const SizedBox():SizedBox(height: 2.h,),
          widget.index==2?
              Container(
                height: 40.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle
                ),
                child: const Center(child: Icon(Icons.add,color: Colors.white,)),
              ):
          Image.asset(
            widget.iconPath,
            width: 28,
            height: 28,
            color:  widget.state.baseActiveBottomIndex == widget.index
                    ? yellowDark
                    : unselectedIconCl,
          ),
          widget.index==2? SizedBox(height: 7.h,):const SizedBox(),
        ],
      ),
    );
  }
}
