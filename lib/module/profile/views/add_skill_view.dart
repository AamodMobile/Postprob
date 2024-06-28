import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/models/list_data_model.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class AddSkillView extends StatefulWidget {
  const AddSkillView({super.key});

  @override
  State<AddSkillView> createState() => _AddSkillViewState();
}

class _AddSkillViewState extends State<AddSkillView> {
  TextEditingController search = TextEditingController();
  List<ListDataModel> searchList = [];
  List<ListDataModel> selectedItem = [];
  late final ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.getSkillsList(context);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<ListDataModel> dummySearchList = [];
    dummySearchList.addAll(profileProvider.skillsList);
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
        searchList.addAll(profileProvider.skillsList);
      });
    }
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
                  "Add Skill",
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
                searchList.isEmpty
                    ? Wrap(
                        spacing: 10.w, // Horizontal spacing between items
                        runSpacing: 10.h, // Vertical spacing between lines
                        children: List.generate(selectedItem.length, (index) {
                          return IntrinsicWidth(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFf0eff2),
                                borderRadius: BorderRadius.circular(10.dm),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 7.w),
                                  Text(
                                    selectedItem[index].title.toString(),
                                    style: TextStyle(
                                      color: mediumTextCl,
                                      fontFamily: regular,
                                      fontSize: 12.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedItem.remove(selectedItem[index]);
                                      });
                                    },
                                    child: Image.asset(
                                      removeIc,
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                    : const SizedBox(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            selectedItem.add(searchList[index]);
                            searchList.clear();
                            search.clear();
                          });
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
          bottomSheet: selectedItem.isEmpty
              ? const SizedBox()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  decoration: const BoxDecoration(color: bgCl),
                  child: Wrap(
                    children: [
                      Column(
                        children: [
                          CustomButtonWidget(
                            onPressed: () {},
                            text: "Save".toUpperCase(),
                          ),
                          SizedBox(height: 90.h)
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
