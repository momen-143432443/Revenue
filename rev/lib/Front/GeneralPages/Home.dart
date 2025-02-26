import 'package:css/Backend/Controllers/ProfileController.dart';
import 'package:css/Backend/Controllers/SignOutController.dart';
import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:css/Backend/RevenueItems/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
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
      mostTrending[indeex].liked = !mostTrending[indeex].liked;
    });
  }

  void _toggleAddToCart(int indeex) {
    setState(() {
      mostTrending[indeex].addToCart = !mostTrending[indeex].addToCart;
    });
  }

  void selected(int index) {
    setState(() {
      selectedFeature = index;
    });
  }

  bool selectedCheck = true;
  int selectedIndex = -1;

  Widget displayInfo = Container();
  void mostOfTrindingRevenue() {
    final siz = MediaQuery.of(context).size;
    setState(() {
      displayInfo = SizedBox(
        width: siz.width * 0.89,
        height: siz.height * 0.4,
        child: ListView.builder(
          itemCount: mostTrending.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, idx) {
            RevenueIemsModel model = mostTrending[idx];

            return GestureDetector(
              onTap: () {},
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
                              style:
                                  GoogleFonts.aleo(fontSize: 15, color: black)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: SizedBox(
                        width: 250,
                        height: 230,
                        child: Image(image: AssetImage(model.imgAdress)),
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
                          onPressed: () {
                            setState(() {
                              return _toggleLike(idx);
                            });
                          },
                          icon: Icon(Iconsax.heart,
                              size: 40,
                              color:
                                  mostTrending[idx].liked ? redColor : black)),
                    ),
                    Positioned(
                      top: 15,
                      left: 130,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.shopping_cart,
                              size: 40, color: black)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }

  void features() {
    setState(() {
      displayInfo = const Center(
        child: Center(child: Text('Loading....')),
      );
    });
  }

  void newsOfRevenue() {
    final siz = MediaQuery.of(context).size;
    setState(() {
      displayInfo = SizedBox(
        width: siz.width * 0.89,
        height: siz.height * 0.4,
        child: ListView.builder(
          itemCount: news.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, idx) {
            RevenueIemsModel model = news[idx];

            return GestureDetector(
              onTap: () {},
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
                              style:
                                  GoogleFonts.aleo(fontSize: 15, color: black)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: SizedBox(
                        width: 250,
                        height: 230,
                        child: Image(image: AssetImage(model.imgAdress)),
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
                              color:
                                  mostTrending[idx].liked ? redColor : black)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
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
                itemsOfTheMostOfTrinding(siz, sym),
                // const SizedBox(height: 15),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Row itemsOfTheMostOfTrinding(Size siz, EdgeInsets sym) {
    SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 40);

    return Row(children: [
      Container(
        width: siz.width / 17,
        height: siz.height / 2,
        margin: EdgeInsets.symmetric(horizontal: siz.width * 0.02),
        child: RotatedBox(
          quarterTurns: -1,
          child: SizedBox(
            child: Row(
              children: [
                GestureDetector(
                  onTap: mostOfTrindingRevenue,
                  child: Text(
                    'Most trinding',
                    style: GoogleFonts.aleo(
                        color: grey, fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
                sizedBoxBewtweenTriggers,
                GestureDetector(
                  onTap: features,
                  child: Text(
                    'features',
                    style: GoogleFonts.aleo(
                        color: grey, fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
                sizedBoxBewtweenTriggers,
                GestureDetector(
                  onTap: newsOfRevenue,
                  child: Text(
                    'new',
                    style: GoogleFonts.aleo(
                        color: grey, fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
                sizedBoxBewtweenTriggers,
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Upcoming',
                    style: GoogleFonts.aleo(
                        color: grey, fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // selectedCheck
      //     ? Center(child: displayInfo)
      //     :
      SizedBox(
        width: siz.width * 0.89,
        height: siz.height * 0.4,
        child: ListView.builder(
          itemCount: mostTrending.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, idx) {
            RevenueIemsModel model = mostTrending[idx];

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = idx;
                });
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
                              style:
                                  GoogleFonts.aleo(fontSize: 15, color: black)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: SizedBox(
                        width: 250,
                        height: 230,
                        child: Image(image: AssetImage(model.imgAdress)),
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
                              color:
                                  mostTrending[idx].liked ? redColor : black)),
                    ),
                    Positioned(
                      top: 325,
                      left: 190,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape:
                                  const WidgetStatePropertyAll(CircleBorder()),
                              backgroundColor: WidgetStatePropertyAll(
                                  mostTrending[idx].addToCart ? lime : grey)),
                          onPressed: () => _toggleAddToCart(idx),
                          child: const Icon(Iconsax.shopping_cart5,
                              size: 30, color: white)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    ]);
  }
}

class UsernameAndProfilePic extends StatelessWidget {
  const UsernameAndProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tkOut = Get.put(SignOutCopntroller());
    final Alerts alerts = Alerts();
    final userData = Get.put(ProfileController());
    final siz = MediaQuery.of(context).size;
    return FutureBuilder<List<UserModel>>(
      future: userData.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              margin: EdgeInsets.only(right: siz.width / 1.2, top: 10),
              child: const Text('Loading..'));
        } else if (snapshot.hasError) {
          return alerts.ifErrors(snapshot.error.toString());
        } else {
          print(snapshot.data);
          List<UserModel> users = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
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
              });
        }
      },
    );
  }
}
