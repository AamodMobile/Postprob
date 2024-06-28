import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/add_project/widgets/add_post_sheet.dart';

class AddProjectView extends StatefulWidget {
  const AddProjectView({super.key});

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  var specializationType = [
    {
      'title': 'Doctor',
      'image': drTypeIc,
      'job': "140 Problems",
    },
    {
      'title': 'Finance',
      'image': financeTypeIc,
      'job': "250 Problems",
    },
    {
      'title': 'Education',
      'image': educationTypeIc,
      'job': "120 Problems",
    },
    {
      'title': 'Restaurant',
      'image': restaurantTypeIc,
      'job': "85 Problems",
    },
    {
      'title': 'Health',
      'image': healthTypeIc,
      'job': "235 Problems",
    },
    {
      'title': 'IT Services',
      'image': itTypeIc,
      'job': "412 Problems",
    },
  ];

  TextEditingController searchQuery = TextEditingController();
  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = specializationType;
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = specializationType;
      });
    } else {
      List<Map<String, String>> tempList = [];
      for (var item in specializationType) {
        if (item['title']!.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      }
      setState(() {
        filteredList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgCl,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Search',
                      controller: searchQuery,
                      obscureText: false,
                      readOnly: false,
                      borderCl: Colors.white,
                      fillColor: Colors.white,
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      leading: Image.asset(
                        searchIc,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.dm),
                        color: yellowDark,
                      ),
                      child: Center(
                        child: Image.asset(
                          filterIc,
                          height: 24.h,
                          width: 24.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                "Specialization",
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
              Expanded(
                child: filteredList.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width),
                    Image.asset(
                      noResultFoundImg,
                      height: 176.h,
                      width: 156.w,
                    ),
                    SizedBox(height: 60.h),
                    Text(
                      "No results found",
                      style: TextStyle(
                        color: mediumTextCl,
                        fontFamily: semiBold,
                        fontSize: 16.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(
                        "The search could not be found, please check spelling or write another word.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: smallTextCl,
                          fontFamily: regular,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
                    : GridView.builder(
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        AddPostSheet.show(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.dm),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 30,
                              spreadRadius: 0,
                              color: Color.fromRGBO(153, 171, 198, 0.2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(18.w),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 245, 243, 1),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                filteredList[index]["image"].toString(),
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Text(
                              filteredList[index]["title"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mediumTextCl,
                                fontFamily: semiBold,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 11.h),
                            Text(
                              filteredList[index]["job"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: hintColor,
                                fontFamily: medium,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
