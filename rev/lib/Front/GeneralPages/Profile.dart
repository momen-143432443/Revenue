import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/SignOutController.dart';
import 'package:css/Backend/Infsructure/Models/UserModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    final tkOut = Get.put(SignOutCopntroller());
    final Alerts alerts = Alerts();
    final userData = Get.put(ProfileController());
    final siz = MediaQuery.of(context).size;
    // Rx<UserModel> user = UserModel.userDataEmpty().obs;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          title: customerServiceAndSettingsButtons(tkOut)),
      backgroundColor: white,
      body: SafeArea(child: SingleChildScrollView(child: Obx(
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
      ))),
    );
  }

  SizedBox showUserDataInScreen(UserModel users) {
    return SizedBox(
      child: Column(
        children: [
          userImageAndFullName(users),
          featuresButtons(),
          border(),
          myOrdersButtons(),
          border(),
          //More of products
          Container(
              margin: const EdgeInsets.only(right: 360),
              child: Text('More!',
                  style: GoogleFonts.aleo(
                      fontSize: 17,
                      color: black,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Column userImageAndFullName(UserModel users) {
    return Column(
      children: [
        const CircleAvatar(radius: 55),
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

  Column myOrdersButtons() {
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
              unpaidOrders(),
              processingOrders(),
              shippedOrders(),
              reviewOrders(),
              feedbackOrders(),
            ],
          ),
        )
      ],
    );
  }

  Column feedbackOrders() {
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

  Column reviewOrders() {
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

  Column shippedOrders() {
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

  Column processingOrders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.archive_sharp),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Processing",
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column unpaidOrders() {
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

  Divider border() {
    return const Divider(
      color: lightGrey,
      thickness: 5,
    );
  }

  Column featuresButtons() {
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
              taxInformation(),
              helpcenter(),
              ordersHistory(),
              legalNotice(),
              revenueWallet(),
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

  Column helpcenter() {
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

  Column taxInformation() {
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

  Container loadingOfPage() {
    return Container(
      margin: const EdgeInsets.only(top: 350),
      child: Center(
        child: LoadingAnimationWidget.progressiveDots(color: lime, size: 55),
      ),
    );
  }

  Row customerServiceAndSettingsButtons(SignOutCopntroller tkOut) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profile',
          style: GoogleFonts.aleo(
              fontSize: 25, color: black, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // It will take us to customer service
              },
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
            ),
            IconButton(
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.transparent)),
                onPressed: () async {
                  // It will take us to settings page
                  await tkOut.signOutTrigger();
                },
                icon: const Icon(Iconsax.setting_2)),
          ],
        )
      ],
    );
  }
}
