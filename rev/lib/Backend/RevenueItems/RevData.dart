import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
// import 'package:css/Tools/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// final List<RevenueIemsModel> mostTrending = [
//   RevenueIemsModel(
//       id: '0',
//       name: "Nike",
//       model: "Men's Black Full-Zip Jacket",
//       itemColor: black,
//       price: 35,
//       liked: false,
//       addToCart: false,
//       imgAdress:
//           "assets/images/Nike Men's Black Full-Zip Chest Swoosh Jacket.webp",
//       colorsAvailable: [black, grey, redColor],
//       rate: const [
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '1',
//       name: "Nike",
//       model: "men sportswear hooded jacket",
//       itemColor: black,
//       price: 30,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress:
//           "assets/images/Nike  Sportswear Club Mens T Shirt  Regular Fit T-Shirts.webp",
//       colorsAvailable: [
//         black,
//         grey,
//       ],
//       rate: const [
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '2',
//       name: "Nike",
//       model: "Men's Training T-Shirt",
//       itemColor: grey,
//       price: 30,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress: "assets/images/Nike Men's Dri-FIT Training T-Shirt.jpg",
//       colorsAvailable: [grey, redColor],
//       rate: const [
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '3',
//       name: "Nike",
//       model: "Men Basketball Shoes",
//       itemColor: grey,
//       price: 30,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress: "assets/images/Nike Men Impact 4 Basketball Shoes.jpg",
//       colorsAvailable: [grey, black, white],
//       rate: const [
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//       ],
//       sizes: ['40', '41', '43', '44', '45'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '4',
//       name: "Nike",
//       model: "Dunk High Men's Shoes",
//       itemColor: blueColor,
//       price: 30,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress: "assets/images/Nike Dunk High By You Custom Men's Shoes.jpg",
//       colorsAvailable: [blueColor, redColor, yellow],
//       rate: const [
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//         Icon(Iconsax.star1, size: 20, color: gold),
//       ],
//       sizes: ['39', '40', '43', '44'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
// ];
// final List<RevenueIemsModel> itemsFeatures = [
//   RevenueIemsModel(
//       id: '5',
//       name: "Gucci",
//       model: "ophidia canvas shoulder bag",
//       itemColor: brown,
//       price: 400,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress: "assets/images/Gucci ophidia Mini GG canvas shoulder bag.webp",
//       colorsAvailable: [brown, grey],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['G23', 'M', 'L'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '6',
//       name: "Gucci",
//       model: "Marmont leather shoulder bag",
//       itemColor: wine,
//       price: 352,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress:
//           "assets/images/Gucci GG Marmont Mini leather shoulder bag.webp",
//       colorsAvailable: [brown, grey],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '6',
//       name: "ZARA",
//       model: "HI-RISE WIDE LEG JEANS",
//       itemColor: black,
//       price: 53,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress: "assets/images/Zara HI-RISE WIDE LEG Black JEANS SZ 0-32.webp",
//       colorsAvailable: [black, grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '7',
//       name: "ZARA",
//       model: "ZARA Saint Laurent",
//       itemColor: sea,
//       price: 45,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress: "assets/images/ZARA Saint Laurent.webp",
//       colorsAvailable: [sea, white, redColor],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '8',
//       name: "ZARA",
//       model: "Shirt Long Sleeve Men'S",
//       itemColor: sea,
//       price: 30,
//       liked: false,
//       addToCart: false,
//       companies: "assets/images/noon.png",
//       imgAdress: "assets/images/Zara Shirt Long Sleeve Navy and Yi Men'S.webp",
//       colorsAvailable: [sea, grey],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '9',
//       name: "ZARA",
//       addToCart: false,
//       model: "Oxford Shirt",
//       price: 54,
//       imgAdress: "assets/images/ZARA Oxford Shirt.webp",
//       itemColor: brown,
//       liked: false,
//       colorsAvailable: [brown, grey, wine],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '10',
//       name: 'ZARA',
//       addToCart: false,
//       model: 'Oversized button shirt placket',
//       price: 34,
//       imgAdress:
//           "assets/images/ZARA Oversized button down shirt in cotton. Center front placket..webp",
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, wine, black],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"])
// ];
// final List<RevenueIemsModel> newItemsOfRev = [
//   RevenueIemsModel(
//       id: '11',
//       name: 'Razer',
//       addToCart: false,
//       model: 'BlackShark V2 X\nGaming Headset',
//       price: 41,
//       imgAdress: "assets/images/Razer BlackShark V2 X Gaming Headset.webp",
//       itemColor: black,
//       liked: false,
//       colorsAvailable: [black, greenColor],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/Imile.png"]),
//   RevenueIemsModel(
//       id: '12',
//       name: 'DIOR',
//       addToCart: false,
//       model: 'Navy Blue Cotton\nHooded',
//       price: 65,
//       imgAdress: "assets/images/DIOR Navy Blue Cotton Hooded Sweatshirt.webp",
//       itemColor: blueColor,
//       liked: false,
//       colorsAvailable: [blueColor, grey],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '13',
//       name: 'DIOR',
//       addToCart: false,
//       model: 'Pajama Pants\nWhite&Blue',
//       price: 55,
//       imgAdress: "assets/images/Dior Oblique Pajama Pants White and Blue.webp",
//       itemColor: blueColor,
//       liked: false,
//       colorsAvailable: [blueColor, sea],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['S', 'M', 'L'],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '14',
//       name: 'Kyile Jenner',
//       addToCart: false,
//       model: 'Matte Lip Kit Matte\nLiquid Lipstick',
//       price: 34,
//       imgAdress:
//           "assets/images/Kylie Jenner Matte Lip Kit Matte Liquid Lipstick.webp",
//       itemColor: pink,
//       liked: false,
//       colorsAvailable: [pink, wine],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: ['N3', 'Wine 2'],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
// ];
// final List<RevenueIemsModel> shoesSection = [
//   RevenueIemsModel(
//       id: '15',
//       name: 'Adidas',
//       addToCart: false,
//       model: 'Grand Court',
//       price: 65,
//       imgAdress: 'assets/images/adidas grand court.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '16',
//       name: 'Adidas',
//       addToCart: false,
//       model: 'Samba OG',
//       price: 55,
//       imgAdress: 'assets/images/adidas samba OG.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU34",
//         "EU39",
//         "EU42",
//         "EU43",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '17',
//       name: 'Adidas',
//       addToCart: false,
//       model: 'Sportswear low top',
//       price: 65,
//       imgAdress: 'assets/images/adidas sportswear low top.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '18',
//       name: 'Dior',
//       addToCart: false,
//       model: 'Dior christian Sneakers',
//       price: 65,
//       imgAdress: 'assets/images/Dior christian Sneakers.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '19',
//       name: 'Dior',
//       addToCart: false,
//       model: 'Dior sneakers B27',
//       price: 65,
//       imgAdress: 'assets/images/Dior sneakers B27.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '20',
//       name: 'Dior',
//       addToCart: false,
//       model: 'Dior star',
//       price: 65,
//       imgAdress: 'assets/images/Dior star.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '21',
//       name: 'Gucci',
//       addToCart: false,
//       model: 'Grand Court',
//       price: 65,
//       imgAdress: 'assets/images/Gucci Ace Leather.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '22',
//       name: 'Nike',
//       addToCart: false,
//       model: 'Dunk Low Retro',
//       price: 65,
//       imgAdress: 'assets/images/Nike Dunk Low Retro.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '23',
//       name: 'Puma',
//       addToCart: false,
//       model: 'Black sport',
//       price: 65,
//       imgAdress: 'assets/images/Puma Black sport.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
//   RevenueIemsModel(
//       id: '24',
//       name: 'Puma',
//       addToCart: false,
//       model: 'Caven white',
//       price: 65,
//       imgAdress: 'assets/images/Puma Caven white.webp',
//       itemColor: grey,
//       liked: false,
//       colorsAvailable: [grey, white],
//       rate: [
//         Icon(Iconsax.star),
//         Icon(Iconsax.star),
//       ],
//       sizes: [
//         "EU40",
//         "EU41",
//         "EU42",
//         "EU43",
//         "EU44",
//       ],
//       countOfItem: 1,
//       companies: "assets/images/noon.png",
//       deliverCompanies: ["assets/images/noon.png", "assets/images/Imile.png"]),
// ];

final List<SearchItemModel> itemsInBag = [];
