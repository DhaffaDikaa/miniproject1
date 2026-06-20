import 'package:flutter/widgets.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String category;
  final String image;
  final String desc;
  final String rating;
  final String reviews;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.image,
    required this.desc,
    required this.rating,
    required this.reviews,
    this.isFavorite = false,
  });

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(id: json['id']?? 0, title: json['title'] ?? 'Tidak Ada Judul', price: json['price'] ?? 0, category: json['category'] ?? '', image: 'assets/images/berries.png',desc:  json['description']??'',rating:  json['rating']?['rate']?.toString() ?? '0.0',reviews:  json['rating']?['count']?.toString() ?? '0',isFavorite: false);
  }

}