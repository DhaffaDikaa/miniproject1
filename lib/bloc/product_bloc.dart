import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductEvent{}

class LoadProductEvent extends ProductEvent{}

class ToggleFavoriteEvent extends ProductEvent{
  final int index;
  ToggleFavoriteEvent(this.index);
}

abstract class ProductState{}

class ProdcutInitial extends ProductState{}

class ProductLoaded extends ProductState{
  final List<Map<String,dynamic>> products;
  ProductLoaded(this.products);
}

class ProductBloc extends Bloc<ProductEvent,ProductState> {
  ProductBloc() : super(ProdcutInitial()){
    final List<Map<String,dynamic>> initialProducts = [
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

    on<LoadProductEvent>((event,emit){
      emit(ProductLoaded(List.from(initialProducts)));
    });

    on<ToggleFavoriteEvent>((event,emit){
      if(state is ProductLoaded){
        final currentProducts = List<Map<String,dynamic>>.from((state as ProductLoaded).products);
        final updatedProduct = Map<String, dynamic>.from(currentProducts[event.index]);
        updatedProduct['isFavorite'] = !updatedProduct['isFavorite'];
        
        currentProducts[event.index] = updatedProduct;
        
        emit(ProductLoaded(currentProducts));
      }
    });
  }
}