import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/module/profile/views/add_language_view.dart';
import 'package:postprob/services/api_url.dart';

class SearchLanguageView extends StatefulWidget {
  const SearchLanguageView({super.key});

  @override
  State<SearchLanguageView> createState() => _SearchLanguageViewState();
}

class _SearchLanguageViewState extends State<SearchLanguageView> {
  /*List languageList = [
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
  ];*/
  //List searchList = [];
  late ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.reset();
    profileProvider.reset1();
    profileProvider.getLanguageList(context, "");
    // searchList = List.from(languageList);
    super.initState();
  }

  /*void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        searchList = List.from(languageList);
      });
      return;
    }

    setState(() {
      searchList = languageList.where((item) => item["tittle"].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, state, child) {
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
                    controller: state.searchLanguage,
                    onChanged: (value) {
                      state.setSearchLanguage(value);
                      state.getLanguageList(context, state.searchLanguage.text);
                    },
                    leading: Image.asset(
                      searchIc,
                      height: 24.h,
                      width: 24.w,
                    ),
                    leading1: state.searchLanguage.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              state.setSearchLanguage("");
                              state.getLanguageList(context, "");
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
                      itemCount: state.languageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            state.setSelectedLanguage(state.languageList[index]);
                            await Future.delayed(const Duration(seconds: 1)).then(
                              (value) {
                                Navigator.push(context, createRightToLeftRoute(AddLanguageView(listDataModel: state.languageList[index], isEdit: false, id: '',)));
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                            margin: EdgeInsets.only(bottom: 15.h),
                            decoration: BoxDecoration(
                              color: state.selectedLanguage == state.languageList[index] ? const Color(0xFFA993FF) : Colors.white,
                              borderRadius: BorderRadius.circular(10.dm),
                              boxShadow: state.selectedLanguage == state.languageList[index]
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
                                  child: state.languageList[index].image != ""
                                      ? CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            koreanFlag,
                                            height: 30.h,
                                            width: 30.w,
                                            fit: BoxFit.cover,
                                          ),
                                          height: 30.h,
                                          width: 30.w,
                                       fit: BoxFit.cover,
                                          imageUrl: ApiUrl.imageUrl + state.languageList[index].image.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Image.asset(
                                          koreanFlag,
                                          height: 30.h,
                                          width: 30.w,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    state.languageList[index].title.toString(),
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
      },
    );
  }
}
