import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'package:postprob/core/common_widgets/route_animation.dart';
import 'package:postprob/module/job_view/view/successful_apply_view.dart';

class UploadCVView extends StatefulWidget {
  const UploadCVView({super.key});

  @override
  State<UploadCVView> createState() => _UploadCVViewState();
}

class _UploadCVViewState extends State<UploadCVView> {
  String? selectedFilePath;
  int? fileSize;
  DateTime? fileDate;

  Future<void> uploadPDFFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.path;
        fileSize = File(selectedFilePath!).lengthSync();
        fileDate = File(selectedFilePath!).lastModifiedSync();
      });

      // Handle the file upload logic here
      // For example, you can upload the file to a server
    } else {
      // User canceled the picker
    }
  }

  void removeSelectedFile() {
    setState(() {
      selectedFilePath = null;
      fileSize = null;
      fileDate = null;
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy \'at\' hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
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
                                  "Need person for Business Development",
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
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Google",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 7,
                                      width: 7,
                                      decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "California",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 7,
                                      width: 7,
                                      decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "1 day ago",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 16.sp,
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
                        height: 94.h,
                        width: 94.w,
                        padding: EdgeInsets.all(12.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFFAFECFE),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(googleIc),
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
                child: selectedFilePath == null
                    ? GestureDetector(
                  onTap: () {
                    uploadPDFFile(context);
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
                      color: Color.fromRGBO(63, 19, 228, 0.05),
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
                                    selectedFilePath!.split('/').last,
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
                                    '${(fileSize! / 1024).toStringAsFixed(2)} KB • ${formatDateTime(fileDate!)}',
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
                          onTap: removeSelectedFile,
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
                ),
              ),
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
                      Navigator.push(context, createRightToLeftRoute(const SuccessfulApplyView()));
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
  }
}
