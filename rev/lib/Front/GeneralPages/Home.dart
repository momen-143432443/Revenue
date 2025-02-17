import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureEvent.dart';
import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureIntegration.dart';
import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureState.dart';
import 'package:css/Backend/Controllers/ProfileController.dart';
import 'package:css/Backend/Controllers/SignOutController.dart';
import 'package:css/Backend/RevenueItems/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';

final controller = Get.put(ProfileController());
final control = Get.put(SignOutCopntroller());

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedFeature = 0;
  int selectItems = 1;
  void _toggleLike(int indeex) {
    setState(() {
      availableIems[indeex].liked = !availableIems[indeex].liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final siz = MediaQuery.of(context).size;
    const EdgeInsets sym = EdgeInsets.symmetric(horizontal: 20);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Center(
            child: Column(
              children: [
                const UsernameAndProfilePic(),
                const SizedBox(height: 65),
                // revFeatured(siz, sym),
                Row(children: [
                  Container(
                    width: siz.width / 16,
                    height: siz.height / 2,
                    margin: EdgeInsets.symmetric(horizontal: siz.width * 0.02),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: SizedBox(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: featured.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Padding(
                                padding: sym,
                                child: Text(
                                  featured[index],
                                  style: GoogleFonts.aleo(
                                      color: selectedFeature == index
                                          ? black
                                          : grey,
                                      fontSize:
                                          selectedFeature == index ? 21 : 18,
                                      fontWeight: selectedFeature == index
                                          ? FontWeight.w600
                                          : FontWeight.w400),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: siz.width * 0.89,
                    height: siz.height * 0.4,
                    child: ListView.builder(
                      itemCount: availableIems.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, idx) {
                        RevenueIemsModel model = availableIems[idx];

                        return GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: siz.height * 0.005,
                                vertical: siz.height * 0.01),
                            width: siz.width / 1.5,
                            child: Stack(
                              children: [
                                Container(
                                  width: siz.width / 1.81,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: model.itemColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 20,
                                  child: Column(
                                    children: [
                                      Text(
                                        model.name,
                                        style: GoogleFonts.aleo(
                                            color: black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text('${model.price} JOD',
                                          style: GoogleFonts.aleo(
                                              fontSize: 15, color: black)),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 50,
                                  child: SizedBox(
                                    width: 250,
                                    height: 230,
                                    child: Image(
                                        image: AssetImage(model.imgAdress)),
                                  ),
                                ),
                                Positioned(
                                    top: 300,
                                    left: 10,
                                    child: Text(
                                      model.model,
                                      style: GoogleFonts.aleo(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: black),
                                    )),
                                Positioned(
                                  top: 5,
                                  left: 190,
                                  child: IconButton(
                                      onPressed: () => _toggleLike(idx),
                                      icon: Icon(Iconsax.heart,
                                          size: 40,
                                          color: availableIems[idx].liked
                                              ? redColor
                                              : black)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ]),
                // const SizedBox(height: 15),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class UsernameAndProfilePic extends StatelessWidget {
  const UsernameAndProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const PopupProfile();
  }
}

class PopupProfile extends StatelessWidget {
  const PopupProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tkOut = Get.put(SignOutCopntroller());
    final Alerts alerts = Alerts();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  FetchNameAndPictureIntegration(ProfileController())
                    ..add(FetchNameAndPictureEventLoading()))
        ],
        child: BlocBuilder<FetchNameAndPictureIntegration,
            FetchNameAndPictureState>(
          builder: (context, state) {
            try {
              if (state is FetchNameAndPictureStateLoading) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Loading..',
                        style: GoogleFonts.aleo(fontSize: 23),
                      ),
                      const CircleAvatar(radius: 25),
                    ],
                  ),
                );
              }
              if (state is FetchNameAndPictureStateLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${state.user.firstName} ${state.user.lastName}',
                        style: GoogleFonts.aleo(fontSize: 23),
                      ),
                      PopupMenuButton<String>(
                          offset: const Offset(22, 34),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem<String>(
                                  value: '1', child: Text('Edit profile')),
                              const PopupMenuItem<String>(
                                  value: '1', child: Text('Send reports')),
                              const PopupMenuItem<String>(
                                  value: '1', child: Text('Switch accounts')),
                              PopupMenuItem<String>(
                                  onTap: () async =>
                                      await tkOut.signOutTrigger(),
                                  value: '1',
                                  child: const Text('Log out')),
                            ];
                          },
                          child: const CircleAvatar(radius: 25)),
                    ],
                  ),
                );
              }
              if (state is FetchNameAndPictureStateError) {
                return const Center(child: Text('Somthing went wrong'));
              }
            } on PlatformException catch (e) {
              alerts.ifErrors(e.toString());
            } catch (e) {
              throw 'Somthing went wrong';
            }
            return Container();
          },
        ));
  }
}
