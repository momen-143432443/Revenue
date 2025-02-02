import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:css/Backend/SceduleSturcture.dart/FetchScheduleAgent.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Swaps extends StatefulWidget {
  const Swaps({super.key});

  @override
  State<Swaps> createState() => _SwapsState();
}

class _SwapsState extends State<Swaps> {
  final scheduleDependOnHridAndUid = Get.put(FetchScheduleAgent());
  Rx<UserModel> hrid = UserModel.userDataEmpty().obs;
  String? userid = AuthenticationRepo.instance.authUser?.uid.toString();
  late Future<List<Map<String, dynamic>>> userSchedule;
  @override
  void initState() {
    super.initState();
    userSchedule = scheduleDependOnHridAndUid.fetchAgentSchedule(
        hrid.value.hrID.toString(), userid!);
  }

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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 65),
              Weeks(width: width, daysOfWeek: daysOfWeek),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: userSchedule,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: LoadingAnimationWidget.beat(
                            color: skyer, size: 55));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No schedule found.'));
                  } else {
                    List<Map<String, dynamic>> schedule = snapshot.data!;

                    return ListView.builder(
                      itemCount: schedule.length,
                      itemBuilder: (context, index) {
                        var item = schedule[index];
                        return ListTile(
                          title: Text('Agent ID: ${item['agent_id']}'),
                          subtitle: Text(
                              'User ID: ${item['user_id']} - Schedule: ${item['schedule']}'),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Weeks extends StatelessWidget {
  const Weeks({
    super.key,
    required this.width,
    required this.daysOfWeek,
  });

  final double width;
  final List<String> daysOfWeek;

  @override
  Widget build(BuildContext context) {
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
