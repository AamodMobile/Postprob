import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/add_project/providers/add__post_provider.dart';
import 'package:postprob/module/add_project/views/shared_job_view.dart';
import 'package:postprob/module/add_project/widgets/choose_problem_type_sheet.dart';
import 'package:postprob/module/add_project/widgets/problem_location_sheet.dart';

class AddPostSecondView extends StatefulWidget {
  final String id;
  const AddPostSecondView({super.key, required this.id});

  @override
  State<AddPostSecondView> createState() => _AddPostSecondViewState();
}

class _AddPostSecondViewState extends State<AddPostSecondView> {
  String problemTittle = "";
  String typeOfWork = "";
  late AddPostProvider addPostProvider;

  @override
  void initState() {
    addPostProvider = context.read<AddPostProvider>();
    addPostProvider.getEmploymentType(context);
    addPostProvider.getCities(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostProvider>(
      builder: (context, state, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: bgCl,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: bgCl,
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: Center(
                    child: Image.asset(
                      removeIc,
                      height: 28,
                      width: 28.w,
                    ),
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    state.createPostProblem(context, widget.id);

                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: yellowDark,
                        fontFamily: medium,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      "Post a problem",
                      style: TextStyle(
                        color: mediumTextCl,
                        fontFamily: medium,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    /* GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const JobPositionSearchView()),
                    );
                    if (result != null) {
                      setState(() {
                        problemTittle = result;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.dm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Problem is for?*",
                              style: TextStyle(
                                color: mediumTextCl,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const JobPositionSearchView()),
                                );
                                if (result != null) {
                                  setState(() {
                                    problemTittle = result;
                                  });
                                }
                              },
                              child: Image.asset(
                                problemTittle == "" ? addCircleIc : editIc,
                                height: 24.h,
                                width: 24.w,
                                color: yellowDark,
                              ),
                            ),
                          ],
                        ),
                        problemTittle == ""
                            ? const SizedBox()
                            : Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Text(
                                    problemTittle,
                                    style: TextStyle(
                                      color: smallTextCl,
                                      fontFamily: regular,
                                      fontSize: 14.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),*/
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () async {
                        await ChooseProblemTypeSheet().show(context, state);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.dm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Type of workplace",
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    await ChooseProblemTypeSheet().show(context, state);
                                  },
                                  child: Image.asset(
                                    state.employmentTypeId == "" ? addCircleIc : editIc,
                                    height: 24.h,
                                    width: 24.w,
                                    color: yellowDark,
                                  ),
                                ),
                              ],
                            ),
                            state.employmentTypeTittle == ""
                                ? const SizedBox()
                                : Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      Text(
                                        state.employmentTypeTittle,
                                        style: TextStyle(
                                          color: smallTextCl,
                                          fontFamily: regular,
                                          fontSize: 14.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () async {
                        await ProblemLocationSheet().show(context,state);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.dm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Problem location",
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    await ProblemLocationSheet().show(context,state);
                                  },
                                  child: Image.asset(
                                    state.locationId == "" ? addCircleIc : editIc,
                                    height: 24.h,
                                    width: 24.w,
                                    color: yellowDark,
                                  ),
                                ),
                              ],
                            ),
                            state.locationTittle == ""
                                ? const SizedBox()
                                : Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      Text(
                                        state.locationTittle,
                                        style: TextStyle(
                                          color: smallTextCl,
                                          fontFamily: regular,
                                          fontSize: 14.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
