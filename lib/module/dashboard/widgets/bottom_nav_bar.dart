import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/dashboard/providers/dashboard_provider.dart';
import 'package:postprob/module/dashboard/widgets/tab_item_widget.dart';
import 'package:provider/provider.dart';

class CommonBottomNavBar extends StatelessWidget {
  const CommonBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (_, state, child) {
        return Container(
          height: 71,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color.fromRGBO(153, 171, 198, 0.18), offset: Offset(0, 4), spreadRadius: 0, blurRadius: 62)],
          ),
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              state.baseIcons.length,
              (index) => TabItemWidget(
                index: index,
                iconPath: state.baseIcons[index],
                state: state,
              ),
            ),
          ),
        );
      },
    );
  }
}
