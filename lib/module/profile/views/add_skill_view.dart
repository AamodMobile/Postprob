
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/models/list_data_model.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';

class AddSkillView extends StatefulWidget {
  final List<ListDataModel> selectedItem;
  final bool isEdit;

  const AddSkillView({super.key, required this.selectedItem, required this.isEdit});

  @override
  State<AddSkillView> createState() => _AddSkillViewState();
}

class _AddSkillViewState extends State<AddSkillView> {
  TextEditingController search = TextEditingController();
  List<ListDataModel> searchList = [];
  List<ListDataModel> selectedItem = [];
  List<String> selectedItemId = [];
  late final ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
    profileProvider.getSkillsList(context).then((_) {
      if (widget.isEdit) {
        setState(() {
          selectedItem = widget.selectedItem;
          selectedItemId = widget.selectedItem.map((e) => e.id.toString()).toList();
        });
      }
    });
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
                width: 30,
                height: 30,
                child: Center(
                  child: Image.asset(
                    backIc,
                    height: 26,
                    width: 26,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Add Skill",
                  style: TextStyle(
                    color: mediumTextCl,
                    fontFamily: medium,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: "Search",
                  controller: search,
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  leading: Image.asset(
                    searchIc,
                    height: 24,
                    width: 24,
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
                      height: 24,
                      width: 24,
                    ),
                  )
                      : const SizedBox(),
                ),
                const SizedBox(height: 40),
                searchList.isEmpty&&selectedItem.isNotEmpty
                    ? Wrap(
                  spacing: 10, // Horizontal spacing between items
                  runSpacing: 10, // Vertical spacing between lines
                  children: List.generate(selectedItem.length, (index) {
                    return IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFf0eff2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 7),
                            Text(
                              selectedItem[index].title.toString(),
                              style: const TextStyle(
                                color: mediumTextCl,
                                fontFamily: regular,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedItemId.remove(selectedItem[index].id.toString());
                                  selectedItem.removeAt(index);
                                });
                              },
                              child: Image.asset(
                                removeIc,
                                height: 24,
                                width: 24,
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
                            if (!selectedItem.contains(searchList[index])) {
                              selectedItem.add(searchList[index]);
                              selectedItemId.add(searchList[index].id.toString());
                            }
                            searchList.clear();
                            search.clear();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            searchList[index].title.toString(),
                            style: const TextStyle(
                              color: hintColor,
                              fontFamily: regular,
                              fontSize: 14,
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
            padding: const EdgeInsets.symmetric(horizontal: 50),
            decoration: const BoxDecoration(color: bgCl),
            child: Wrap(
              children: [
                Column(
                  children: [
                    CustomButtonWidget(
                      onPressed: () {
                        if (selectedItemId.isEmpty) {
                          errorToast(context, "Select Skill");
                        } else {
                          state.skillsAdd(context, selectedItemId);
                        }
                      },
                      text: "SAVE",
                    ),
                    const SizedBox(height: 90)
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
