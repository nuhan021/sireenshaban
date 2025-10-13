import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatController extends GetxController {
  List<ChatModel> chats = [
    ChatModel(
      name: "Floyd Miles",
      lastMessage: "Hey! How have you been?",
      time: "10:24 AM",
      avatar: "https://www.maxim.com/wp-content/uploads/2021/05/gettyimages-685153930.jpg",
    ),
    ChatModel(
      name: "Courtney Henry",
      lastMessage: "Let’s meet tomorrow at the café.",
      time: "Yesterday",
      avatar: "https://thumbs.dreamstime.com/b/beautiful-model-brunette-long-curled-hair-luxury-fashion-style-nails-manicure-cosmetics-make-up-dense-curly-pefect-63340149.jpg",
    ),
    ChatModel(
      name: "Eleanor Pena",
      lastMessage: "I’ve sent you the documents.",
      time: "Mon",
      avatar: "https://thumbs.dreamstime.com/b/sexy-hot-beautiful-girl-model-dark-hair-stylish-clothes-high-fashion-look-glamor-sunbathed-caucasian-colorful-swimsuit-92829697.jpg",
    ),
    ChatModel(
      name: "Jerome Bell",
      lastMessage: "Can you call me when you’re free?",
      time: "Sun",
      avatar: "https://images.unsplash.com/photo-1524502397800-2eeaad7c3fe5?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YmVhdXRpZnVsJTIwbW9kZWx8ZW58MHx8MHx8fDA%3D&fm=jpg&q=60&w=3000",
    ),
    ChatModel(
      name: "Savannah Nguyen",
      lastMessage: "Got it! Thanks for letting me know.",
      time: "Sat",
      avatar: "https://img.freepik.com/premium-photo/beauty-portrait-fashion-young-model-sexy-beauty-woman-face-sensual-young-woman-headshot-beautiful-sexy-model-portrait-beauty-female-face-sensual-girl-sexy-model-portrait-natural-beauty_265223-177735.jpg?w=360",
    ),
    ChatModel(
      name: "Marvin McKinney",
      lastMessage: "Let’s schedule the meeting for next week.",
      time: "Fri",
      avatar: "https://www.shutterstock.com/image-photo/beautiful-black-hair-woman-portrait-600nw-713928289.jpg",
    ),
    ChatModel(
      name: "Jacob Jones",
      lastMessage: "I’ll be there in 15 minutes.",
      time: "Thu",
      avatar: "https://images-cdn.ubuy.co.id/6608b6bf7198c9558d10a0b0-mikayla-demaiter-sexy-female-model.jpg",
    ),
    ChatModel(
      name: "Kristin Watson",
      lastMessage: "Happy Birthday! 🎉",
      time: "Wed",
      avatar: "https://i.pinimg.com/474x/fb/2c/63/fb2c6316b69336f260a4396850138aaa.jpg",
    ),
    ChatModel(
      name: "Annette Black",
      lastMessage: "That sounds awesome!",
      time: "Tue",
      avatar: "https://i.pinimg.com/736x/c1/5d/02/c15d020633bd1f59d15979ae9219912c.jpg",
    ),
    ChatModel(
      name: "Devon Lane",
      lastMessage: "See you at the gym later?",
      time: "Mon",
      avatar: "https://e1.pxfuel.com/desktop-wallpaper/83/286/desktop-wallpaper-best-16-beautiful-hot-indian-actress-and-models-high-resolution-indian-models.jpg",
    ),
  ];
}

class ChatModel {
  ChatModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
  });

  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
}
