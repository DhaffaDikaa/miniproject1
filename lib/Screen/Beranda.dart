import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Detail.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int _current = 0;
  final List<String> dataGambarSlide = [
    "assets/images/gs1.png",
    "assets/images/gs2.png",
    "assets/images/gs3.png",
  ];

  final List<Map<String, String>> dataGambarCategories = [
    {"title": "Fruits", "image": "assets/images/gc1(fruit).png"},
    {"title": "Grains", "image": "assets/images/gc2(grains).png"},
    {"title": "Herbs", "image": "assets/images/gc3(herbs).png"},
    {"title": "Veggies", "image": "assets/images/gc4(veggies).png"},
    {"title": "Diary", "image": "assets/images/gc5(diary).png"},
  ];

  final List<Map<String, dynamic>> products = [
    {
      "title": "Berries",
      "image": "assets/images/berries.png",
      "rating": "4.5",
      "reviews": "672",
      "desc": "Berries is a sweet fruit with red color.",
      "isFavorite": false,
    },
    {
      "title": "Tulsi",
      "image": "assets/images/tulsi.png",
      "rating": "4.9",
      "reviews": "324",
      "desc": "Leaf of berries is very green.",
      "isFavorite": false,
    },
    {
      "title": "Milk",
      "image": "assets/images/milk.png",
      "rating": "4.5",
      "reviews": "672",
      "desc": "Does chocolate milk come from brown cows?.",
      "isFavorite": false,
    },
    {
      "title": "Tomato",
      "image": "assets/images/tomato.png",
      "rating": "4.9",
      "reviews": "324",
      "desc": "Is tomato a fruit or a vegetable?",
      "isFavorite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KebunGO',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 20),

              _searchBar(),

              const SizedBox(height: 18),

              CarouselSlider(
                items: dataGambarSlide.map((imagePath) {
                  return _buildBannerItem(imagePath);
                }).toList(),
                options: CarouselOptions(
                  height: 134,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dataGambarSlide.asMap().entries.map((entry) {
                  return Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key ? Colors.green : Colors.grey,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 15),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataGambarCategories.map((kategori) {
                    return _buildCategoryItem(
                      kategori['title']!,
                      kategori['image']!,
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Produk Dicari',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 15),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.6,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final produk = products[index];
                  return _buildProductCard(produk);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Pencarian',
        hintStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildBannerItem(String imagePath) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.only(left: 6, right: 16, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(imagePath),
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(produk: product)),
        ).then((value) {
          setState(() {});
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  product['image'],
                  height: 142,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      product['isFavorite'] = !product['isFavorite'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      product['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product['isFavorite'] ? Colors.red : Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            product['title'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                product['rating'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${product['reviews']})',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            product['desc'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
