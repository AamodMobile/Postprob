import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/connection/models/post_deatils_model.dart';
import 'package:postprob/module/connection/providers/connection_provider.dart';
import 'package:postprob/services/api_url.dart';

class UploadCVView extends StatefulWidget {
  final String id;
  final PostDetailsModel postDetailsModel;
  const UploadCVView({super.key, required this.id, required this.postDetailsModel});

  @override
  State<UploadCVView> createState() => _UploadCVViewState();
}

class _UploadCVViewState extends State<UploadCVView> {
  late ConnectionProvider connectionProvider;

  @override
  void initState() {
    connectionProvider = context.read<ConnectionProvider>();
    connectionProvider.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(
      builder: (context, state, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: bgCl,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
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
                                      /*  Expanded(
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
                                            state.postDetailsModel.user!=null?
                                            "${state.postDetailsModel.user!.city ?? ""},${ state.postDetailsModel.user!.state ?? ""}":"",
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
                            child:  state.postDetailsModel.user!=null&&state.postDetailsModel.user!.image != ""
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
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Upload CV",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mediumTextCl,
                        fontFamily: semiBold,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 11.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Add your CV/Resume to apply for a job",
                      textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: smallTextCl,
                        fontFamily: regular,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: state.selectedFilePath == ""
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
                                              state.selectedFilePath.split('/').last,
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
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Information",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mediumTextCl,
                        fontFamily: semiBold,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomTextField(
                      hintText: "Explain why you are the right person for this Problem",
                      fillColor: Colors.white,
                      maxCheck: 5,
                      controller: state.info,
                    ),
                  ),
                  SizedBox(height: 70.h),
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
                        onPressed: () {
                          if (state.selectedFilePath == "") {
                            errorToast(context, "Please add your resume");
                          }else if (state.info.text == "") {
                            errorToast(context, "Please add post info");
                          } else {
                            state.jobApply(context, widget.id,state.info.text);
                          }
                        },
                        text: "PROCEED",
                      ),
                      SizedBox(height: 27.h)
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
