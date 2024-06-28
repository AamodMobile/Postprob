import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';

class JobLocationSearchView extends StatefulWidget {
  const JobLocationSearchView({super.key});

  @override
  State<JobLocationSearchView> createState() => _JobLocationSearchViewState();
}

class _JobLocationSearchViewState extends State<JobLocationSearchView> {
  TextEditingController search = TextEditingController();
  List<String> jobLocation = [
    "Califon, United States",
    "California, United States",
    "California City, United States",
  ];
  List<String> searchList = [];

  @override
  void initState() {
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(jobLocation);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        searchList.clear();
        searchList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        searchList.clear();
        searchList.addAll(jobLocation);
      });
    }
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
                  height: 26.h,
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
              SizedBox(height: 30.h),
              Text(
                "Problem is for?",
                style: TextStyle(
                  color: mediumTextCl,
                  fontFamily: medium,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
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
              SizedBox(height: 40.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.pop(context, searchList[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30.h),
                        child: Text(
                          searchList[index],
                          style: TextStyle(
                            color: smallTextCl,
                            fontFamily: regular,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
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
