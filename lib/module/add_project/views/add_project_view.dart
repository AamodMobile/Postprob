import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/add_project/providers/add__post_provider.dart';
import 'package:postprob/module/add_project/views/add_post_view.dart';
import 'package:postprob/module/add_project/widgets/add_post_sheet.dart';
import 'package:postprob/services/api_url.dart';

class AddProjectView extends StatefulWidget {
  const AddProjectView({super.key});

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  late AddPostProvider addPostProvider;

  @override
  void initState() {
    addPostProvider = context.read<AddPostProvider>();
    addPostProvider.reset();
    addPostProvider.getCategoryList(context).then((value) {
      addPostProvider.filteredList = addPostProvider.categoryList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostProvider>(
      builder: (context, state, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: bgCl,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return LoaderClass(height: MediaQuery.of(context).size.height - 200);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Search',
                              controller: state.searchQuery,
                              obscureText: false,
                              readOnly: false,
                              borderCl: Colors.white,
                              fillColor: Colors.white,
                              onChanged: (value) {
                                addPostProvider.filterSearchResults(value);
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
                        child: addPostProvider.filteredList.isEmpty
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
                                itemCount: addPostProvider.filteredList.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of items per row
                                  crossAxisSpacing: 15.w,
                                  mainAxisSpacing: 15.h,
                                  childAspectRatio: 1 / 1.2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      AddPostSheet.show(context, () => Navigator.push(context, createRightToLeftRoute(AddPostView(id: addPostProvider.filteredList[index].id.toString()))));
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
                                            child: addPostProvider.filteredList[index].image != ""
                                                ? CachedNetworkImage(
                                                    errorWidget: (context, url, error) => Image.asset(
                                                      itTypeIc,
                                                      height: 30.h,
                                                      width: 30.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    height: 30.h,
                                                    width: 30.w,
                                                 fit: BoxFit.cover,
                                                    imageUrl: ApiUrl.imageUrl + addPostProvider.filteredList[index].image.toString(),
                                                    placeholder: (a, b) => const Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  )
                                                : Image.asset(
                                                    itTypeIc,
                                                    height: 30.h,
                                                    width: 30.w,
                                                  ),
                                          ),
                                          SizedBox(height: 18.h),
                                          Text(
                                            addPostProvider.filteredList[index].title.toString(),
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
                                            addPostProvider.filteredList[index].title.toString(),
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
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
