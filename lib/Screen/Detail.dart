import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../bloc/product_bloc.dart'; 

class Detail extends StatefulWidget {
  final int productIndex; 

  const Detail({super.key, required this.productIndex});

  @override
  State<Detail> createState() => _detailState();
}

class _detailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            final produk = state.products[widget.productIndex];

            return Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        produk['image'],
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.5),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<ProductBloc>().add(
                                  ToggleFavoriteEvent(widget.productIndex),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.5),
                                child: Icon(
                                  produk['isFavorite']
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: produk['isFavorite']
                                      ? Colors.red
                                      : Colors.black,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            produk['title'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                produk['rating'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${produk['reviews']})',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        produk['desc'],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
