import 'package:css/Backend/Controllers/ForCustomerServiceControllers/CustomerServiceController.dart';
import 'package:css/Backend/Infsructure/Models/CustomerService.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Chats extends StatefulWidget {
  const Chats({super.key, required this.senderId, required this.receiverId});
  final String senderId;
  final String receiverId;

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final CustomerServiceController controller =
      Get.put(CustomerServiceController());
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchMessage(widget.senderId, widget.receiverId);
    controller.fetchMessage(widget.senderId, widget.receiverId).then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.slowMiddle,
            );
          }
        });
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: appBarOfCustomerService(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: LoadingAnimationWidget.progressiveDots(
                      color: lime, size: 55),
                );
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
                }
              });
              return showMessages(size);
            }),
          ),
          MessageField(
            size: size,
            textController: textController,
            controller: controller,
            widget: widget,
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }

  AppBar appBarOfCustomerService() {
    return AppBar(
      backgroundColor: white,
      title: Text(
        'Customer Service',
        style: GoogleFonts.aleo(
            fontSize: 25, color: black, fontWeight: FontWeight.w500),
      ),
    );
  }

  ListView showMessages(Size size) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final msg = controller.messages[index];
        final isMe = msg.senderId == widget.senderId;

        return popUpOptions(context, size, isMe, msg);
      },
    );
  }

  SizedBox popUpOptions(
      BuildContext context, Size size, bool isMe, CustomerService msg) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onLongPress: () {
              Widget buildMethods(IconData icon, String label,
                  {bool isDestructive = false}) {
                return ListTile(
                  leading: Icon(icon,
                      color: isDestructive ? Colors.red : Colors.white),
                  title: Text(
                    label,
                    style: GoogleFonts.aleo(
                      fontSize: 16,
                      color: isDestructive ? Colors.red : Colors.white,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                );
              }

              final GlobalKey stackKey = GlobalKey();
              showGeneralDialog(
                  barrierDismissible: false,
                  transitionDuration: const Duration(milliseconds: 300),
                  context: context,
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
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
                  pageBuilder: (context, animation1, animation2) => Dialog(
                        key: stackKey,
                        backgroundColor: const Color(0xFF1C1C1E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        insetPadding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 250),
                        child: SizedBox(
                          width: size.width / 1.4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildMethods(Icons.reply, 'Reply'),
                                buildMethods(Iconsax.trash, 'WithDraw')
                              ],
                            ),
                          ),
                        ),
                      ));
            },
            child: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isMe ? greenColor : grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  msg.message,
                  style: const TextStyle(color: black),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: isMe ? greenColor : grey,
            child: const Icon(
              Iconsax.user,
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}

class MessageField extends StatelessWidget {
  const MessageField(
      {super.key,
      required this.size,
      required this.textController,
      required this.controller,
      required this.widget,
      required this.scrollController});

  final Size size;
  final TextEditingController textController;
  final ScrollController scrollController;
  final CustomerServiceController controller;
  final Chats widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [addPictureToChat(), addTextToChat(), sendTextToChat()],
      ),
    );
  }

  Stack sendTextToChat() {
    return Stack(children: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.send1, size: 28, color: greenColor),
      ),
      Positioned(
        bottom: 1,
        child: IconButton(
          onPressed: () async {
            if (textController.text.trim().isEmpty) return;

            await controller.sendMessages(
                widget.senderId, widget.receiverId, textController.text.trim());
            textController.clear();
            await controller.fetchMessage(
                widget.senderId, widget.receiverId); // reload chat
            Future.delayed(
              const Duration(milliseconds: 100),
              () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollController.hasClients) {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(seconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });
              },
            );
          },
          icon: const Icon(Iconsax.send1, size: 22, color: white),
        ),
      ),
    ]);
  }

  Container addTextToChat() {
    return Container(
      width: size.width / 1.6,
      height: size.height * 0.08,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(color: grey),
      child: TextFormField(
        controller: textController,
        cursorColor: Colors.black,
        style: const TextStyle(color: black),
        decoration: InputDecoration(
          labelText: 'Text Message',
          labelStyle: const TextStyle(color: black),
          filled: true,
          fillColor: lightGrey,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  IconButton addPictureToChat() =>
      IconButton(onPressed: () {}, icon: const Icon(Iconsax.add));
}
