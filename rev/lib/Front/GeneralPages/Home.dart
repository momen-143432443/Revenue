import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureEvent.dart';
import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureIntegration.dart';
import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureState.dart';
import 'package:css/Backend/Controllers/ProfileController.dart';
import 'package:css/Backend/Controllers/SignOutController.dart';
import 'package:css/Front/GeneralPages/Swaps.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

final controller = Get.put(ProfileController());

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final List<String> daysOfWeek = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    final List<String> shifts = [
      '17:00 pm - 02:00 am',
      '17:00 pm - 02:00 am',
      '17:00 pm - 02:00 am',
      'Off',
      '17:00 pm - 02:00 am',
      '17:00 pm - 02:00 am',
      'Off'
    ];
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Center(
            child: Column(
              children: [
                const UsernameAndProfilePic(),
                const SizedBox(height: 65),
                const AgentScedule(),
                const SizedBox(height: 15),
                Weeks(daysOfWeek: daysOfWeek),
                AgentSifts(shifts: shifts),
                const SizedBox(height: 15),
                const SwapsButton()
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class SwapsButton extends StatelessWidget {
  const SwapsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2,
      child: ElevatedButton.icon(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(blueColor)),
        onPressed: () => Get.to(() => const Swaps()),
        label: const Text("Swaps", style: TextStyle(color: white)),
        icon: const Icon(
          Iconsax.arrow_swap,
          color: white,
        ),
      ),
    );
  }
}

class AgentScedule extends StatelessWidget {
  const AgentScedule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                FetchNameAndPictureIntegration(ProfileController())
                  ..add(FetchNameAndPictureEventLoading()),
          )
        ],
        child: BlocBuilder<FetchNameAndPictureIntegration,
            FetchNameAndPictureState>(
          builder: (context, push) {
            try {
              if (push is FetchNameAndPictureStateLoading) {
                return Padding(
                  padding: const EdgeInsets.only(right: 266),
                  child: Text(
                    'username schedule',
                    style: GoogleFonts.aleo(fontSize: 15),
                  ),
                );
              } else if (push is FetchNameAndPictureStateLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(right: 266),
                  child: Text(
                    "${push.user.firstName}${push.user.lastName} schedule",
                    style: GoogleFonts.aleo(fontSize: 15),
                  ),
                );
              } else if (push is FetchNameAndPictureStateError) {
                return Padding(
                  padding: const EdgeInsets.only(right: 266),
                  child: Text(
                    "Error found name",
                    style: GoogleFonts.aleo(fontSize: 15),
                  ),
                );
              }
            } on PlatformException catch (e) {
              return ifErrors(e.message.toString());
            }
            return const Text('Data');
          },
        ));
  }
}

class AgentSifts extends StatelessWidget {
  const AgentSifts({
    super.key,
    required this.shifts,
  });

  final List<String> shifts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: shifts.map((dailySifts) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              color: csGrey,
              child: Text(
                dailySifts,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Weeks extends StatelessWidget {
  const Weeks({
    super.key,
    required this.daysOfWeek,
  });

  final List<String> daysOfWeek;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 30,
        width: width,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: daysOfWeek.map((day) {
            return Container(
              width: width / 7,
              color: skyer,
              child: Center(
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ));
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
              ifErrors(e.toString());
            } catch (e) {
              throw 'Somthing went wrong';
            }
            return Container();
          },
        ));
  }
}
