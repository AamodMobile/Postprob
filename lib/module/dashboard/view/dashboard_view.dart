import 'package:flutter/material.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/dashboard/providers/dashboard_provider.dart';
import 'package:postprob/module/dashboard/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, state, child) {
      return WillPopScope(
        onWillPop: () async {
          final dashboardProvider = context.read<DashboardProvider>();
          return dashboardProvider.onWillPop(context);
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate the height offset based on 10 units below the bottom
                final heightOffset = (constraints.maxHeight + 10) / constraints.maxHeight;
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final slideTransition = Tween<Offset>(
                      begin: Offset(0.0, heightOffset),
                      end: Offset.zero,
                    ).animate(animation);

                    final fadeTransition = Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(animation);

                    return FadeTransition(
                      opacity: fadeTransition,
                      child: SlideTransition(
                        position: slideTransition,
                        child: child,
                      ),
                    );
                  },
                  child: IndexedStack(
                    key: ValueKey<int>(state.baseActiveBottomIndex),
                    index: state.baseActiveBottomIndex,
                    children: state.baseWidgets,
                  ),
                );
              },
            ),
            bottomNavigationBar: const CommonBottomNavBar(),
          ),
        ),
      );
    });
  }
}
