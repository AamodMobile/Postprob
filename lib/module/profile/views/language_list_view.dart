import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/profile/views/search_language_view.dart';
import 'package:postprob/module/profile/widgets/remove_item_sheet.dart';

class LanguageListView extends StatefulWidget {
  const LanguageListView({super.key});

  @override
  State<LanguageListView> createState() => _LanguageListViewState();
}

class _LanguageListViewState extends State<LanguageListView> {
  List listLanguage = [
    {"tittle": "Indonesian(First language)", "icon": indonesianFlag, "level": "Oral : Level 10", "written_level": "Written : Level 10"},
    {"tittle": "English", "icon": englishUkFlag, "level": "Oral : Level 8", "written_level": "Written : Level 8"},
  ];

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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackCl,
                      fontFamily: semiBold,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchLanguageView()));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Add",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: blueLight,
                            fontFamily: semiBold,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Image.asset(
                          circleAddBlueIc,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: ListView.builder(
                  itemCount: listLanguage.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.dm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.dm),
                                child: Image.asset(
                                  listLanguage[index]["icon"],
                                  height: 30.h,
                                  width: 30.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  listLanguage[index]["tittle"].toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: semiBold,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  RemoveItemSheet.show(context, listLanguage[index]["tittle"].toString(), "${listLanguage[index]["tittle"]} language");
                                },
                                child: Image.asset(
                                  deleteIc,
                                  height: 24.h,
                                  width: 24.w,
                                  color: redCl,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            listLanguage[index]["level"].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: hintColor,
                              fontFamily: regular,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            listLanguage[index]["written_level"].toString(),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
