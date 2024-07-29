import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/chat/views/message_view.dart';
import 'package:postprob/module/connection/providers/connection_provider.dart';
import 'package:postprob/module/dashboard/view/dashboard_view.dart';
import 'package:postprob/services/api_url.dart';

class SuccessfulApplyView extends StatefulWidget {
  const SuccessfulApplyView({super.key});

  @override
  State<SuccessfulApplyView> createState() => _SuccessfulApplyViewState();
}

class _SuccessfulApplyViewState extends State<SuccessfulApplyView> {
  late ConnectionProvider connectionProvider;

  @override
  void initState() {
    connectionProvider = context.read<ConnectionProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(
      builder: (context, state, child) {
        return WillPopScope(
          onWillPop: () async {
            bool willLeave = false;
            Navigator.pushReplacement(
                context,
                createLeftToRightRoute(const DashboardView(
                  index: 0,
                )));
            return willLeave;
          },
          child: SafeArea(
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
                    Navigator.pushReplacement(
                        context,
                        createLeftToRightRoute(const DashboardView(
                          index: 0,
                        )));
                  },
                  child: SizedBox(
                    width: 30.w,
                    height: 30.h,
                    child: Center(
                      child: Image.asset(
                        backIc,
                        height: 26,
                        width: 26.w,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Image.asset(
                      optionsIc,
                      width: 24.h,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 177.h,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(color: Color(0xFFF3F2F2)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 36.h,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                      child: Text(
                                        state.postDetailsModel.title.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: semiBold,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        children: [
                                          /* Expanded(
                                            child: Text(
                                              "Google",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: blackCl,
                                                fontFamily: medium,
                                                fontSize: 14.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: 7,
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                          ),*/
                                          Expanded(
                                            child: Text(
                                              state.postDetailsModel.city!.title.toString(),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: blackCl,
                                                fontFamily: medium,
                                                fontSize: 14.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: 7,
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                          ),
                                          Expanded(
                                            child: Text(
                                              state.postDetailsModel.postedAt.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: blackCl,
                                                fontFamily: medium,
                                                fontSize: 14.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: 84.h,
                              width: 84.w,
                              padding: EdgeInsets.all(10.w),
                              decoration: const BoxDecoration(
                                color: Color(0xFFAFECFE),
                                shape: BoxShape.circle,
                              ),
                              child: state.postDetailsModel.user!.image != ""
                                  ? Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30.dm),
                                        child: CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            demoUser,
                                            height: 60.h,
                                            width: 60.w,
                                            fit: BoxFit.cover,
                                          ),
                                          height: 60.h,
                                          width: 60.w,
                                          fit: BoxFit.cover,
                                          imageUrl: ApiUrl.imageUrl + state.postDetailsModel.user!.image.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Image.asset(googleIc),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.dm),
                          color: const Color.fromRGBO(63, 19, 228, 0.05),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  pdfIc,
                                  height: 44.h,
                                  width: 44.w,
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.successModel.resume.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: mediumTextCl,
                                          fontFamily: regular,
                                          fontSize: 12.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        formatDate(
                                          state.successModel.createdAt.toString(),
                                        ),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: hintColor,
                                          fontFamily: regular,
                                          fontSize: 12.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Image.asset(
                      successfullyApplyImg,
                      height: 150.h,
                      width: 152.w,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Successful",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackCl,
                        fontFamily: semiBold,
                        fontSize: 16.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Congratulations, your application has been sent",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: smallTextCl,
                        fontFamily: regular,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
              bottomSheet: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                decoration: const BoxDecoration(color: bgCl),
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        CustomButtonWidget(
                          style: CustomButtonStyle.style2,
                          onPressed: () {
                            Navigator.push(
                              context,
                              createLeftToRightRoute(
                                MessageView(
                                  id: state.successModel.jobDetail!.user!.id.toString(),
                                  user: state.successModel.jobDetail!.re!,
                                  userId: state.successModel.userId.toString(),
                                ),
                              ),
                            );
                          },
                          text: "OPEN PERSON CHAT NOW",
                        ),
                        SizedBox(height: 20.h),
                        CustomButtonWidget(
                          onPressed: () {
                            Navigator.pushReplacement(context, createLeftToRightRoute(const DashboardView(index: 0)));
                          },
                          text: "BACK TO HOME",
                        ),
                        SizedBox(height: 10.h)
                      ],
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat outputFormat = DateFormat('d MMM yyyy \'at\' h:mm a');
    return outputFormat.format(dateTime);
  }
}
