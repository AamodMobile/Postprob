import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/views/add_language_view.dart';

class SearchLanguageView extends StatefulWidget {
  const SearchLanguageView({super.key});

  @override
  State<SearchLanguageView> createState() => _SearchLanguageViewState();
}

class _SearchLanguageViewState extends State<SearchLanguageView> {
  int selectedIndex = -1;
  TextEditingController search = TextEditingController();
  List languageList = [
    {"tittle": "Arabic", "icon": arabicFlag},
    {"tittle": "Indonesian", "icon": indonesianFlag},
    {"tittle": "Malaysian", "icon": malaysianFlag},
    {"tittle": "English", "icon": englishUkFlag},
    {"tittle": "French", "icon": frenchFlag},
    {"tittle": "German", "icon": germanFlag},
    {"tittle": "Hindi", "icon": hindiIndianFlag},
    {"tittle": "Italian", "icon": italianFlag},
    {"tittle": "Japanese", "icon": japaneseFlag},
    {"tittle": "Korean", "icon": koreanFlag},
  ];
  List searchList = [];

  @override
  void initState() {
    searchList = List.from(languageList);
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        searchList = List.from(languageList);
      });
      return;
    }

    setState(() {
      searchList = languageList.where((item) => item["tittle"].toLowerCase().contains(query.toLowerCase())).toList();
    });
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
                    "Add Language",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackCl,
                      fontFamily: semiBold,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                hintText: "Search",
                controller: search,
                onChanged: (value) {
                  filterSearchResults(value);
                },
                leading: Image.asset(
                  searchIc,
                  height: 24.h,
                  width: 24.w,
                ),
                leading1: search.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            search.clear();
                            filterSearchResults('');
                          });
                        },
                        child: Image.asset(
                          removeIc,
                          height: 24.h,
                          width: 24.w,
                        ),
                      )
                    : const SizedBox(),
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: ListView.builder(
                  itemCount: searchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          selectedIndex = index;
                        });
                        await Future.delayed(const Duration(seconds: 1)).then(
                          (value) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddLanguageView()));
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        margin: EdgeInsets.only(bottom: 15.h),
                        decoration: BoxDecoration(
                          color: selectedIndex == index ? const Color(0xFFA993FF) : Colors.white,
                          borderRadius: BorderRadius.circular(10.dm),
                          boxShadow: selectedIndex == index
                              ? [
                                  const BoxShadow(
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                    blurRadius: 62,
                                    color: Color.fromRGBO(153, 171, 198, 0.18),
                                  )
                                ]
                              : null,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.dm),
                              child: Image.asset(
                                searchList[index]["icon"],
                                height: 30.h,
                                width: 30.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                searchList[index]["tittle"],
                                style: TextStyle(
                                  color: mediumTextCl,
                                  fontFamily: semiBold,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
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
