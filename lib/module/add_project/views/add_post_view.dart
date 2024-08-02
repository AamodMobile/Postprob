import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/core/utils/image_picker_utils.dart';
import 'package:postprob/module/add_project/providers/add__post_provider.dart';
import 'package:postprob/module/add_project/views/add_post_second_view.dart';
import 'package:postprob/module/add_project/widgets/hash_tag_popup.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/services/api_url.dart';

class AddPostView extends StatefulWidget {
  final String id;

  const AddPostView({super.key, required this.id});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).userGetProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AddPostProvider, ProfileProvider>(
      builder: (context, addPostState, profileState, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: bgCl,
            resizeToAvoidBottomInset: true,
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
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (addPostState.postImage.path == "") {
                        errorToast(context, "Add Image");
                      } else {
                        Navigator.push(context, createRightToLeftRoute(AddPostSecondView(id: widget.id)));
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: yellowDark,
                        fontFamily: medium,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        "Add Post",
                        style: TextStyle(
                          color: mediumTextCl,
                          fontFamily: medium,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.dm),
                            child: profileState.profileModel.image != ""
                                ? CachedNetworkImage(
                                    errorWidget: (context, url, error) => Image.asset(
                                      demoUser,
                                      height: 56.h,
                                      width: 56.w,
                                      fit: BoxFit.cover,
                                    ),
                                    height: 56.h,
                                    width: 56.w,
                                    fit: BoxFit.cover,
                                    imageUrl: ApiUrl.imageUrl + profileState.profileModel.image.toString(),
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Image.asset(
                                    demoUser,
                                    height: 56.h,
                                    width: 56.w,
                                  ),
                          ),
                          SizedBox(width: 11.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileState.profileModel.name ?? "",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${profileState.profileModel.city ?? " "},${profileState.profileModel.state ?? " "}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: smallTextCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 28.h),
                      CustomTextField(
                        labelText: "Post title",
                        hintText: "Write the title of your post here",
                        controller: addPostState.title,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter post title";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        labelText: "Post Position",
                        hintText: "Write post position",
                        controller: addPostState.position,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter post position";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        labelText: "Description",
                        hintText: "What do you want to talk about?",
                        maxCheck: 6,
                        controller: addPostState.description,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter post description";
                          }
                          return null;
                        },
                      ),
                      addPostState.tags.isNotEmpty
                          ? Column(
                              children: [
                                SizedBox(height: 25.h),
                                Wrap(
                                  spacing: 10.w, // Horizontal spacing between items
                                  runSpacing: 10.h, // Vertical spacing between lines
                                  children: List.generate(addPostState.tags.length, (index) {
                                    return Container(
                                      width: (MediaQuery.of(context).size.width - 40.w) / 3.9,
                                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFf5f4f6),
                                        borderRadius: BorderRadius.circular(10.dm),
                                      ),
                                      child: Center(
                                        child: Text(
                                          addPostState.tags[index].toString(),
                                          style: TextStyle(
                                            color: mediumTextCl,
                                            fontFamily: regular,
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(height: 20.h),
                      addPostState.postImage.path != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.dm),
                              child: Image.file(
                                addPostState.postImage,
                                height: 200.h,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              decoration: const BoxDecoration(color: Colors.white),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var value = ImageSource.camera;
                                  File? pickedFile = await PickImageUtility.instance(
                                    applyEditor: true,
                                    context: context,
                                  ).pickedFile(value);
                                  if (pickedFile != null) {
                                    setState(() {
                                      addPostState.postImage = pickedFile;
                                    });
                                  }
                                },
                                child: Image.asset(
                                  cameraIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var value = ImageSource.gallery;
                                  File? pickedFile = await PickImageUtility.instance(
                                    applyEditor: true,
                                    context: context,
                                  ).pickedFile(value);
                                  if (pickedFile != null) {
                                    setState(() {
                                      addPostState.postImage = pickedFile;
                                    });
                                  }
                                },
                                child: Image.asset(
                                  galleryIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              var result = await showDialog(
                                context: context,
                                builder: (_) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24.dm),
                                      ),
                                    ),
                                    child: HashTagPupUp(
                                      addPostProvider: addPostState,
                                    ),
                                  );
                                },
                              );
                              if (result != null) {
                                setState(() {});
                              }
                            },
                            child: Text(
                              "Add hashtag",
                              style: TextStyle(
                                color: yellowDark,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
