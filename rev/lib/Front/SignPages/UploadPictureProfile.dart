import 'dart:io';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/SignUpConroller.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart' as getx;
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class UploadPictureProfile extends StatefulWidget {
  final String uid;
  const UploadPictureProfile({required this.uid, super.key});

  @override
  State<UploadPictureProfile> createState() => _UploadPictureProfileState();
}

class _UploadPictureProfileState extends State<UploadPictureProfile> {
  final controller = getx.Get.put(SignupConroller());
  final picController = getx.Get.put(ProfileController());
  File? _image;
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    } else if (picked == null) {
      setState(() {
        _image = null;
      });
    }
  }

  Future<void> submitImage() async {
    await controller.uploadPic(widget.uid, _image);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            youCanTakeAPhotoOrChoosingAPictureFromYourStudioOrYouCanSkipAndAddYouProfilePictureLater(),
            showUserImageUploaded(),
            continueButtonTrigger(size)
          ],
        ),
      )),
    );
  }

  SizedBox continueButtonTrigger(Size size) {
    return SizedBox(
        width: size.width / 1.4,
        child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(blueColor)),
            onPressed: () => submitImage(),
            child: Text(
              'Continue',
              style:
                  GoogleFonts.aleo(color: white, fontWeight: FontWeight.w400),
            )));
  }

  GestureDetector showUserImageUploaded() {
    return GestureDetector(
      onTap: () => pickImage(),
      child: _image != null
          ? CircleAvatar(
              backgroundColor: grey,
              radius: 50,
              backgroundImage: FileImage(_image!),
            )
          : const CircleAvatar(
              backgroundColor: grey,
              radius: 50,
              child: Icon(
                Iconsax.add,
                color: white,
              ),
            ),
    );
  }

  Text
      youCanTakeAPhotoOrChoosingAPictureFromYourStudioOrYouCanSkipAndAddYouProfilePictureLater() {
    return Text(
      "You Can Take A Photo Or Choosing A Picture From Your Studio, Or You Can Skip And Add You Profile Picture Later",
      style: GoogleFonts.aleo(fontWeight: FontWeight.w400),
    );
  }
}
