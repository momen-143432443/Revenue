import 'package:css/Backend/RevenueItems/ItemsModel.dart';
import 'package:css/Tools/Colors.dart';

final List<RevenueIemsModel> mostTrending = [
  RevenueIemsModel(
      name: "Nike",
      model: "Men's Black Full-Zip\n Chest Swoosh Jacket",
      itemColor: black,
      price: 35,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Men's Black Full-Zip Chest Swoosh Jacket.webp"),
  RevenueIemsModel(
      name: "Nike",
      model: "men sportswear storm fit\n windrunner hooded jacket ",
      itemColor: black,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress:
          "assets/Nike  Sportswear Club Mens T Shirt  Regular Fit T-Shirts.webp"),
  RevenueIemsModel(
      name: "Nike",
      model: "Men's Dri-FIT\n Training T-Shirt",
      itemColor: grey,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Men's Dri-FIT Training T-Shirt.jpg"),
  RevenueIemsModel(
      name: "Nike",
      model: "Men Impact 4\n Basketball Shoes",
      itemColor: grey,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Men Impact 4 Basketball Shoes.jpg"),
  RevenueIemsModel(
      name: "Nike",
      model: "Dunk High By You Custom\n Men's Shoes.jpg",
      itemColor: blueColor,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Dunk High By You Custom Men's Shoes.jpg"),
];
final List<RevenueIemsModel> news = [
  RevenueIemsModel(
      name: "Nike",
      model: "men sportswear storm fit\n windrunner hooded jacket ",
      itemColor: black,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress:
          "assets/Nike  Sportswear Club Mens T Shirt  Regular Fit T-Shirts.webp"),
  RevenueIemsModel(
      name: "Nike",
      model: "Men's Black Full-Zip\n Chest Swoosh Jacket",
      itemColor: black,
      price: 35,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Men's Black Full-Zip Chest Swoosh Jacket.webp"),
  RevenueIemsModel(
      name: "Nike",
      model: "Men's Dri-FIT\n Training T-Shirt",
      itemColor: grey,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Men's Dri-FIT Training T-Shirt.jpg"),
  RevenueIemsModel(
      name: "Nike",
      model: "Men Impact 4\n Basketball Shoes",
      itemColor: grey,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Men Impact 4 Basketball Shoes.jpg"),
  RevenueIemsModel(
      name: "Nike",
      model: "Dunk High By You Custom\n Men's Shoes.jpg",
      itemColor: blueColor,
      price: 30,
      liked: false,
      addToCart: false,
      imgAdress: "assets/Nike Dunk High By You Custom Men's Shoes.jpg"),
];

final List featured = ['Featured', 'Upcoming', 'New', 'Most trending'];
List featuredtriggers(int index) => [mostTrending, news];
