import 'dart:convert';
import 'dart:typed_data';

import 'package:css/Backend/Controllers/ForProductControllers/MoreSectionController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/SignOutController.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Backend/Infsructure/Models/UserModel.dart';
import 'package:css/Front/ForOrders/ProcessingOrdersPage.dart';
import 'package:css/Front/GeneralPages/CustomerServicePage.dart';
import 'package:css/Front/GeneralPages/SearchPage.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final moreSec = getx.Get.put(MoreSectionController());
const SizedBox spaceBetweenExpansionButtons = SizedBox(height: 7);
const SizedBox spaceBetweenWidgets = SizedBox(width: 10);

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userData = getx.Get.put(ProfileController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: customerServiceAndSettingsButtons(),
        shadowColor: white,
      ),
      backgroundColor: white,
      body: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 20,
        animSpeedFactor: 20,
        height: 35,
        showChildOpacityTransition: false,
        backgroundColor: white,
        color: greenColor,
        onRefresh: () async => moreSec.moreItems,
        child: SafeArea(child: getx.Obx(
          () {
            final user = userData.user.value;
            if (user.email == null || user.email!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Center(
                    child: LoadingAnimationWidget.progressiveDots(
                        color: lime, size: 55)),
              );
            }
            return showUserDataInScreen(user);
          },
        )),
      ),
      endDrawer: SettingsAndActivity(size: size),
    );
  }

  SizedBox showUserDataInScreen(UserModel users) {
    final siz = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(
        children: [
          Column(
            children: [
              userImageAndFullName(users),
              const FeaturesList(),
              border(),
              const MyOrdersSection(),
              border(),
              //////////////////////////
              ///////More Section///////
              /////////////////////////
              moreTextSectoin(),
            ],
          ),
          listOfItemOfMoreSection(siz)
        ],
      ),
    );
  }

  Container moreTextSectoin() {
    return Container(
        margin: const EdgeInsets.only(right: 360),
        child: Text('More!',
            style: GoogleFonts.aleo(
                fontSize: 17, color: black, fontWeight: FontWeight.w500)));
  }

  Expanded listOfItemOfMoreSection(Size siz) {
    return Expanded(
      child: SizedBox(
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75, // Adjust as needed
          ),
          itemCount: moreSec.moreItems.length,
          itemBuilder: (context, index) {
            final item = moreSec.items[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: grey),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: siz.height * 0.010,
                vertical: siz.height * 0.01,
              ),
              width: siz.width / 1.5,
              child: Stack(
                children: [
                  Image.memory(base64Decode(item.imgAdress),
                      fit: BoxFit.contain),
                  Positioned(
                    top: 200,
                    left: 4,
                    child: Row(
                      children: [
                        Text(item.name,
                            style: GoogleFonts.aleo(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(width: 2),
                        Text(item.model,
                            style: GoogleFonts.aleo(
                                color: black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  rateItemInshowModalBottomSheet(siz, item),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget rateItemInshowModalBottomSheet(Size size, RevenueIemsModel model) {
    // print("Rate for item: ${model.model}");
    int fullStars = model.rate.floor();
    bool hasHalfStar = (model.rate - fullStars) >= 0.5;
    return Positioned(
      top: size.height / 4.2,
      left: size.width * 0.02,
      child: SizedBox(
          child: Row(
        children: [
          Text('${model.price} JOD',
              style: GoogleFonts.aleo(
                  color: black, fontSize: 13, fontWeight: FontWeight.w700)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              5,
              (index) {
                if (index < fullStars) {
                  return const Icon(Icons.star, color: Colors.amber, size: 18);
                } else if (index == hasHalfStar && hasHalfStar) {
                  return const Icon(Icons.star_half,
                      color: Colors.amber, size: 18);
                } else {
                  return const Icon(Icons.star_border,
                      color: Colors.amber, size: 18);
                }
              },
            ),
          ),
        ],
      )),
    );
  }

  Column userImageAndFullName(UserModel users) {
    return Column(
      children: [
        buildProfileImage(userData.user.value.userPic),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${users.firstName} ${users.lastName}',
          style: GoogleFonts.aleo(
              fontSize: 25, color: black, fontWeight: FontWeight.w500),
        ),
        const Divider(
          color: lightGrey,
          thickness: 5,
        )
      ],
    );
  }

  Divider border() {
    return const Divider(
      color: lightGrey,
      thickness: 5,
    );
  }

  Container loadingOfPage() {
    return Container(
      margin: const EdgeInsets.only(top: 350),
      child: Center(
        child: LoadingAnimationWidget.progressiveDots(color: lime, size: 55),
      ),
    );
  }

  Widget buildProfileImage(String? base64Image) {
    if (base64Image == null || base64Image.isEmpty) {
      return const CircleAvatar(
        backgroundColor: grey,
        radius: 50,
        child: Icon(
          color: white,
          Iconsax.user,
          size: 35,
        ),
      );
    }

    try {
      final bytes = base64Decode(base64Image);
      return CircleAvatar(
        radius: 50,
        backgroundImage: MemoryImage(bytes),
      );
    } catch (e) {
      return const CircleAvatar(
        radius: 50,
        child: Icon(
          Icons.error,
          size: 35,
          color: white,
        ),
      );
    }
  }

  Row customerServiceAndSettingsButtons() {
    /* final networkImage = userData.user.value.userPic;
    final iamge = networkImage!= null?networkImage:'' */
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profile',
          style: GoogleFonts.aleo(
              fontSize: 25, color: black, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: () => getx.Get.to(() => const CustomerServicePage(),
              transition: getx.Transition.rightToLeft),
          child: const Stack(
            children: [
              Positioned(
                right: 3.1,
                bottom: 7,
                child: Icon(
                  Icons.headset_mic_rounded,
                  size: 18,
                ),
              ),
              Icon(Iconsax.user, size: 24)
            ],
          ),
        )
      ],
    );
  }
}

class MyOrdersSection extends StatelessWidget {
  const MyOrdersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 320),
            child: Text('My Orders',
                style: GoogleFonts.aleo(
                    fontSize: 17, color: black, fontWeight: FontWeight.w500))),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // unpaidOrder(),
              processingOrder(),
              shippedOrder(),
              reveiwOrder(),
              feedbackOrder()
            ],
          ),
        )
      ],
    );
  }

  Column feedbackOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.keyboard_double_arrow_left_sharp),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Feedback",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column reveiwOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.message_2),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Review",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column shippedOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.truck),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Shipped",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  GestureDetector processingOrder() {
    return GestureDetector(
      onTap: () => getx.Get.to(() => const ProcessingOrdersPage(),
          transition: getx.Transition.rightToLeft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Iconsax.arrow_swap_horizontal),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Processing",
            style: GoogleFonts.aleo(
                fontSize: 10, color: black, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Column unpaidOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.document),
        Text(
          "Unpaid",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class FeaturesList extends StatelessWidget {
  const FeaturesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 340),
            child: Text('Features',
                style: GoogleFonts.aleo(
                    fontSize: 17, color: black, fontWeight: FontWeight.w500))),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              taxInformations(),
              helpCenter(),
              ordersHistory(),
              legalNotice(),
              revenueWallet()
            ],
          ),
        )
      ],
    );
  }

  Column revenueWallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.wallet_1),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Wallet",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column legalNotice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.balance_rounded),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Legal notice",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column ordersHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.bag),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Orders History",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column helpCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.help_outline_rounded),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Help Center",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column taxInformations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.dollar_circle),
        Text(
          "Tax\ninformations",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class SettingsAndActivity extends StatelessWidget {
  const SettingsAndActivity({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final tkOut = getx.Get.put(SignOutCopntroller());
    return Drawer(
      backgroundColor: white,
      width: size.width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                settingsAndActivityText(),
                const SizedBox(
                  height: 10,
                ),
                const ShareWithOthers(),
                const AboutOrders(),
                const AboutAccount(),
                const AboutUs()
              ],
            ),
            logoutFromAccountButton(tkOut, context)
          ],
        ),
      ),
    );
  }

  GestureDetector logoutFromAccountButton(
      SignOutCopntroller tkOut, BuildContext context) {
    return GestureDetector(
      onTap: () => showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionDuration: const Duration(milliseconds: 300),
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            final curved =
                CurvedAnimation(parent: animation, curve: Curves.ease);
            return ScaleTransition(
              scale: curved,
              child: FadeTransition(
                opacity: curved,
                child: child,
              ),
            );
          },
          pageBuilder: (context, animation1, animation2) => AlertDialog(
                backgroundColor: white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                title: Text(
                  "Sign Out.",
                  style: GoogleFonts.aleo(
                      color: black, fontWeight: FontWeight.w600),
                ),
                content: SingleChildScrollView(
                  child: Text(
                    "Are You Sure You Want To Signout?",
                    style: GoogleFonts.aleo(
                        color: black, fontWeight: FontWeight.w400),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () async => await tkOut.signOutTrigger(),
                      child: const Text(
                        "Sign out",
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Back",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Iconsax.logout,
            color: redColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Log Out",
            style: GoogleFonts.aleo(
                fontSize: 11, color: black, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Container settingsAndActivityText() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "R",
              style: GoogleFonts.italianno(
                  fontSize: 35, color: greenColor, fontWeight: FontWeight.w500),
            ),
            Text(
              'evenue',
              style: GoogleFonts.italianno(
                  fontSize: 30, color: greenColor, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'About Us',
        style: GoogleFonts.aleo(
            fontSize: 13, color: black, fontWeight: FontWeight.w700),
      ),
      children: [
        privacyAndCookiePolicy(),
        spaceBetweenExpansionButtons,
        termsAndConditions(),
        spaceBetweenExpansionButtons,
        ratingAndReview(),
        spaceBetweenExpansionButtons,
        adChoice(),
        spaceBetweenExpansionButtons,
        helpCenter(),
        spaceBetweenExpansionButtons,
        aboutRevenue()
      ],
    );
  }

  Row helpCenter() {
    return Row(
      children: [
        const Stack(
          children: [
            Positioned(
              right: 3.1,
              bottom: 7,
              child: Icon(
                Icons.headset_mic_rounded,
                size: 18,
              ),
            ),
            Icon(Iconsax.user)
          ],
        ),
        spaceBetweenWidgets,
        Text(
          "Help Center",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row aboutRevenue() {
    return Row(
      children: [
        Text(
          "R",
          style: GoogleFonts.italianno(
              fontSize: 30, color: greenColor, fontWeight: FontWeight.w500),
        ),
        spaceBetweenWidgets,
        Text(
          "About Revenue",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row adChoice() {
    return Row(
      children: [
        const Stack(
          children: [
            Icon(Icons.monitor),
            Positioned(
                left: 5,
                top: 4,
                child: Icon(
                  Iconsax.coin,
                  size: 13,
                ))
          ],
        ),
        spaceBetweenWidgets,
        Text(
          "Ad Choice",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row ratingAndReview() {
    return Row(
      children: [
        const Icon(Iconsax.star),
        spaceBetweenWidgets,
        Text(
          "Rating&Review",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row termsAndConditions() {
    return Row(
      children: [
        const Stack(children: [
          Icon(Iconsax.user),
          Positioned(
              top: 11.5,
              left: 5.5,
              child: Icon(
                Iconsax.book_1,
                size: 13,
                weight: 502,
              ))
        ]),
        spaceBetweenWidgets,
        Text(
          'Terms&Condition',
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row privacyAndCookiePolicy() {
    return Row(
      children: [
        const Icon(Icons.privacy_tip_rounded),
        spaceBetweenWidgets,
        Text(
          "Privacy & Cookie Policy",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class AboutOrders extends StatelessWidget {
  const AboutOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: Text(
        "About Orders",
        style: GoogleFonts.aleo(
            fontSize: 13, color: black, fontWeight: FontWeight.w700),
      ),
      children: [
        ordersHistory(),
        spaceBetweenExpansionButtons,
        taxinformations(),
        spaceBetweenExpansionButtons,
        currency(),
        spaceBetweenExpansionButtons,
        addressBook(),
      ],
    );
  }

  Row addressBook() {
    return Row(
      children: [
        const Icon(Iconsax.location5),
        spaceBetweenWidgets,
        Text(
          'Address Book',
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row currency() {
    return Row(
      children: [
        const Icon(Iconsax.coin),
        spaceBetweenWidgets,
        Text(
          "Currency",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row ordersHistory() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.bag),
        spaceBetweenWidgets,
        Text(
          "Orders History",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row taxinformations() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.dollar_circle),
        spaceBetweenWidgets,
        Text(
          "Tax\ninformations",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class AboutAccount extends StatelessWidget {
  const AboutAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: Text(
        "About Account",
        style: GoogleFonts.aleo(
            fontSize: 13, color: black, fontWeight: FontWeight.w700),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            accountCreated(),
            spaceBetweenExpansionButtons,
            twoStepVerification(),
            spaceBetweenExpansionButtons,
            changePassword(),
            spaceBetweenExpansionButtons,
            recoveryPhone(),
          ],
        ),
      ],
    );
  }

  Row recoveryPhone() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(children: [
          const Icon(Icons.phone_android),
          Positioned(
              top: 4.5,
              left: 10.5,
              child: Text("!",
                  style: GoogleFonts.aleo(
                      fontSize: 12, color: black, fontWeight: FontWeight.w700)))
        ]),
        spaceBetweenWidgets,
        Text(
          "Recovery Phone",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row changePassword() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.password_outlined),
        spaceBetweenWidgets,
        Text(
          "Change Password",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row twoStepVerification() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Stack(
          children: [
            Icon(Iconsax.security),
            Positioned(
              top: 6,
              left: 6.6,
              child: Icon(
                Iconsax.lock_1,
                size: 11,
              ),
            ),
          ],
        ),
        spaceBetweenWidgets,
        Text(
          "2-Step Verification",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row accountCreated() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.date_range_outlined),
        spaceBetweenWidgets,
        Text(
          "Account Created",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class ShareWithOthers extends StatelessWidget {
  const ShareWithOthers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: Text(
        "Share With Others",
        style: GoogleFonts.aleo(
            fontSize: 13, color: black, fontWeight: FontWeight.w700),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sendGifts(),
            spaceBetweenExpansionButtons,
            invites(),
          ],
        )
      ],
    );
  }

  Row invites() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.add_circle),
        spaceBetweenWidgets,
        Text(
          "Send Invites",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Row sendGifts() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Iconsax.search_favorite),
        spaceBetweenWidgets,
        Text(
          "Send Gift To Your Friends",
          style: GoogleFonts.aleo(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
