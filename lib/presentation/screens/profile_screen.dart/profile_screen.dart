import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lenore/application/provider/profile_provider/profile_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/edit_profile_screen.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/screens/profile_screen.dart/widget/user_detail_column.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).fetchProfile(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNWMzYmQxNmM1M2RiZTczZjU0ZTMwN2JlM2VhOWY0MmVjMjVmYWY3YjJmNTM1ZDFmNjA2Y2QxYTkzZGU4ZDViZTk2MzNiMjU3NjkwZTA0NTgiLCJpYXQiOjE3MzAxMTc3NTIuODE5ODM4LCJuYmYiOjE3MzAxMTc3NTIuODE5ODM5LCJleHAiOjE3NjE2NTM3NTIuODE3OTM1LCJzdWIiOiIzMCIsInNjb3BlcyI6W119.l7fSzgKjbtP_CyqfcVJo5LV7iV5dN_WtLVjfZyMPcf9qFXQrGv3wtRmJ63b02UkxsV8zexEXBrwhmL6bu4aCpBcKM6RFHld2AInk3ulrjESyuc5IVbiG7d6Alr36VRJeOuC2BUG_jAMi2KKYmzq5HV2oDqBMMEXTQ5eDKKA31T2RwQyDJM65dbm0nRbNOrBdymv179r9d1U7BbmfBd7KfxbRODfIqE8cGS0adeXPCn9QdekTxDk2WdzTTW31XbusnFmkvMlA8km1YJg53-NLHGrGvAxaPC9DQwtBAlrFriXtpBPOZ89JLtGoAMKV-n8WwntiOCnVL6K09y82RC1ysqUA_6qnk3FpPlHOchEoBWFAddQJ2m7COjVT5ozbf_j6f0qP0TSCgDzrfNKD46VIoe70UBs2koHRSs-aa95SukJazaYwL7du2LIGEikv35x3fvHeh450j3BdbBOSiC0J2V1G5NEtPY8Pa0DqX4dXCMHCcbq4GABxFM8vdGlCn_6Ke1SgsW5Rq4yhJrIfqEi8mbGQEboWi4yeONzVj5wH-ZTUVbSGjm1mvr_-uf9In01gARYlMOKgJ8tohiAmU6m-GC0xekWhN9nEeTXx4OLhv23JJT7odf1sYQxkWCey6Q5kdqztmg7wmWeqSsUv4aGJ7XowrXHFYxD0Zyd-S0ftUlA');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: querySize.height * 0.07),
              child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: querySize.width * 0.02),
                    child: Consumer<ProfileProvider>(
                      builder: (context, profileValue, child) {
                        if (profileValue.showGif) {
                          return lenoreGif(querySize);
                        }
                        if (profileValue.profile == null) {
                          return SizedBox();
                        }

                        return Column(
                          children: [
                            customHeightThree(querySize),
                            CircleAvatar(
                              radius: querySize.width * 0.13,
                              foregroundImage:
                                  profileValue.profile!.data.image != null
                                      ? NetworkImage(
                                          profileValue.profile!.data.image!)
                                      : AssetImage(
                                          'assets/images/profile/profile_picture_image.png',
                                        ),
                            ),
                            customSizedBox(querySize),
                            Text(
                              "My Profile",
                              style: TextStyle(
                                color: const Color(0xFF00ACB3),
                                fontSize: querySize.height * 0.022,
                                fontFamily: 'Segoe',
                              ),
                            ),
                            customSizedBox(querySize),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: querySize.width * 0.07),
                              child: Column(
                                children: [
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/first_name_icon.png",
                                    columnHeading: 'First Name',
                                    columnName:
                                        profileValue.profile!.data.fName,
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/second_name_icon.png",
                                    columnHeading: 'Last Name',
                                    columnName:
                                        profileValue.profile!.data.lName == null
                                            ? ""
                                            : profileValue.profile!.data.lName!,
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/email_icon.png",
                                    columnHeading: 'Email ID',
                                    columnName:
                                        profileValue.profile!.data.email,
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/qatar_flag_icon.png",
                                    columnHeading: 'Mobile Number',
                                    columnName:
                                        '+974 ${profileValue.profile!.data.phone}',
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/qid_icon.png",
                                    columnHeading: 'QID/ PASSPORT',
                                    columnName: profileValue.profile!.data.qId,
                                  ),
                                  customSizedBox(querySize),
                                  userDetailColumn(
                                    context: context,
                                    assetName:
                                        "assets/images/profile/qid_icon.png",
                                    columnHeading: 'Gender',
                                    columnName:
                                        profileValue.profile!.data.gender == '1'
                                            ? 'Male'
                                            : "female",
                                  ),
                                  customSizedBox(querySize),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfileScreen(),
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00ACB3),
                                      minimumSize: Size(
                                        querySize.width * (137 / 375),
                                        querySize.height * (42 / 812),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Edit Profile',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  customSizedBox(querySize),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )),
              ),
            ),
            Positioned(
              top: querySize.height * 0.02,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                child: customProfileTopBar(querySize, context, 'Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
