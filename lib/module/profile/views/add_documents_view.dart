import 'package:dotted_border/dotted_border.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';

class AddDocumentsView extends StatefulWidget {
  const AddDocumentsView({super.key});

  @override
  State<AddDocumentsView> createState() => _AddDocumentsViewState();
}

class _AddDocumentsViewState extends State<AddDocumentsView> {
  late ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.userGetProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, state, child) {
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
                    backIc,
                    height: 26,
                    width: 26.w,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: state.profileModel.documents != null && state.profileModel.documents!.isNotEmpty ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            "Your Documents",
                            style: TextStyle(
                              color: mediumTextCl,
                              fontFamily: medium,
                              fontSize: 14.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.profileModel.documents?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    DottedBorder(
                                      color: const Color(0xFF9D97B5),
                                      strokeWidth: 1,
                                      borderType: BorderType.RRect,
                                      padding: EdgeInsets.zero,
                                      radius: Radius.circular(20.dm),
                                      dashPattern: const [3, 3],
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
                                                        state.profileModel.documents![index].title.toString(),
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
                                                        '',
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
                                            SizedBox(height: 20.h),
                                            GestureDetector(
                                              onTap: () {
                                                state.deleteUserDocument(context, state.profileModel.documents![index].id.toString());
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    deleteIc,
                                                    height: 24.h,
                                                    width: 24.w,
                                                    color: redCl,
                                                  ),
                                                  SizedBox(width: 15.w),
                                                  Text(
                                                    "Remove file",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: redCl,
                                                      fontFamily: medium,
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
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 30.h),
                  Text(
                    "Add Documents",
                    style: TextStyle(
                      color: mediumTextCl,
                      fontFamily: medium,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  state.selectedFilePath == null
                      ? GestureDetector(
                          onTap: () {
                            state.uploadPDFFile(context);
                          },
                          child: DottedBorder(
                            color: const Color(0xFF9D97B5),
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20.dm),
                            dashPattern: const [3, 3],
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 25.h),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.dm),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    uploadFileIc,
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                  SizedBox(width: 15.w),
                                  Text(
                                    "Upload CV/File",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: mediumTextCl,
                                      fontFamily: regular,
                                      fontSize: 12.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : DottedBorder(
                          color: const Color(0xFF9D97B5),
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          padding: EdgeInsets.zero,
                          radius: Radius.circular(20.dm),
                          dashPattern: const [3, 3],
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
                                            state.selectedFilePath!.split('/').last,
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
                                            '${(state.fileSize! / 1024).toStringAsFixed(2)} KB • ${state.formatDateTime(state.fileDate!)}',
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
                                SizedBox(height: 20.h),
                                GestureDetector(
                                  onTap: state.removeSelectedFile,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        deleteIc,
                                        height: 24.h,
                                        width: 24.w,
                                        color: redCl,
                                      ),
                                      SizedBox(width: 15.w),
                                      Text(
                                        "Remove file",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: redCl,
                                          fontFamily: medium,
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
                          ),
                        ),
                  SizedBox(height: 15.h),
                  Text(
                    "Upload files in PDF format up to 5 MB. Just upload it once and you can use it in your next application.",
                    style: TextStyle(
                      color: hintColor,
                      fontFamily: regular,
                      fontSize: 10.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 80.h),
                ],
              ),
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
                      onPressed: () {
                        if (state.selectedFilePath != null) {
                          state.addUserDocumentsApi(context, "", state.selectedFilePath!.split('/').last, state.selectedFilePath.toString());
                        } else {
                          errorToast(context, "Select Document");
                        }
                      },
                      text: "SAVE".toUpperCase(),
                    ),
                    SizedBox(height: 20.h)
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
