import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/models/list_data_model.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';

class LevelOfEducation extends StatefulWidget {
  const LevelOfEducation({super.key});

  @override
  State<LevelOfEducation> createState() => _LevelOfEducationState();
}

class _LevelOfEducationState extends State<LevelOfEducation> {
  TextEditingController search = TextEditingController();
  List<ListDataModel> searchList = [];
  late final ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.getEducationLevelList(context);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<ListDataModel> dummySearchList = [];
    dummySearchList.addAll(profileProvider.educationLevelList);
    if (query.isNotEmpty) {
      List<ListDataModel> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.title.toString().toLowerCase().contains(query.toLowerCase())) {
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
        searchList.addAll(profileProvider.educationLevelList);
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
                "Level of Education",
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
                      onTap: () {
                        Navigator.pop(context, searchList[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Text(
                          searchList[index].title.toString(),
                          style: TextStyle(
                            color: hintColor,
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
