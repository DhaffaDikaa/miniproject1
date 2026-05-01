import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  final Map<String,dynamic>produk;

  const Detail({super.key,required this.produk});

  @override
  State<Detail> createState() => _detailState();
}

class _detailState extends State<Detail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight:Radius.circular(30),
                ),
                child: Image.asset(
                  widget.produk['image'],
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
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
                        onTap: (){
                          setState(() {
                            widget.produk['isFavorite'] = !widget.produk['isFavorite'];
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.5),
                          child: Icon(
                            widget.produk['isFavorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.produk['isFavorite']
                                ? Colors.red
                                : Colors.black,
                            size: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.produk['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          widget.produk['rating'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.produk['reviews']})',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 15,),

                Text(
                  widget.produk['desc'],
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
      ),
    );
  }
}