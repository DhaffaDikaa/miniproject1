import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject1/models/product_model.dart';
import '../services/api_service.dart';
abstract class ProductEvent{}

class LoadProductEvent extends ProductEvent{}

class ToggleFavoriteEvent extends ProductEvent{
  final int index;
  ToggleFavoriteEvent(this.index);
}

abstract class ProductState{}

class ProdcutInitial extends ProductState{}
class ProductLoading extends ProductState{}

class ProductLoaded extends ProductState{
  final List<ProductModel> products;
  final bool isOffline;
  final String errorMessage;
  ProductLoaded(this.products,{this.isOffline = false,this.errorMessage = ""});
}

class ProductBloc extends Bloc<ProductEvent,ProductState> {
  final ApiService apiService;
    final List<ProductModel> initialProducts = [
ProductModel(
      id: 1,
      title: "Berries",
      price: 0,
      category: "Fruits",
      image: "assets/images/berries.png",
      rating: "4.5",
      reviews: "672",
      desc: "Berries is a sweet fruit with red color.",
      isFavorite: false,
    ),
    ProductModel(
      id: 2,
      title: "Tulsi",
      price: 0,
      category: "Herbs",
      image: "assets/images/tulsi.png",
      rating: "4.9",
      reviews: "324",
      desc: "Leaf of berries is very green.",
      isFavorite: false,
    ),
    ProductModel(
      id: 3,
      title: "Milk",
      price: 0,
      category: "Dairy",
      image: "assets/images/milk.png",
      rating: "4.5",
      reviews: "672",
      desc: "Does chocolate milk come from brown cows?",
      isFavorite: false,
    ),
    ProductModel(
      id: 4,
      title: "Tomato",
      price: 0,
      category: "Veggies",
      image: "assets/images/tomato.png",
      rating: "4.9",
      reviews: "324",
      desc: "Is tomato a fruit or a vegetable?",
      isFavorite: false,
    ),
  ];    
    ProductBloc(this.apiService) : super(ProdcutInitial()){
    on<LoadProductEvent>((event,emit) async{
      emit(ProductLoading());
      List<ProductModel> currentProducts = [];
      if(state is ProductLoaded){
        currentProducts = (state as ProductLoaded).products;
      }

      try{
        final response = await apiService.getProducts();
        final List<dynamic> data = response.data;
        final List<ProductModel> fetchedProducts = data.map((item) => ProductModel.fromJson(item)).toList(); 
        emit(ProductLoaded(fetchedProducts));
      }on DioException catch (e){
        String errorText = 'Terjadi Kesalahan sistem.';
        if(e.type == DioExceptionType.connectionError){
          errorText = "Koneksi terputus.Memuat data Offline";
        }
        final dataYangDitampilkan = currentProducts.isNotEmpty ? currentProducts : initialProducts;
        emit(ProductLoaded(dataYangDitampilkan,isOffline: true,errorMessage: errorText));
      }
    });

    on<ToggleFavoriteEvent>((event,emit){
      if (state is ProductLoaded){
        final currentState = state as ProductLoaded;
        final currentList = List<ProductModel>.from(currentState.products);

        currentList[event.index].isFavorite = !currentList[event.index].isFavorite;

        emit(ProductLoaded(currentList,isOffline:  currentState.isOffline,errorMessage: currentState.errorMessage));
      }
    });
  }
}