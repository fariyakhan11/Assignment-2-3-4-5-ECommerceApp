import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_store_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {


  List<Product> _products = [];

  List<Product> get products {
    return [..._products]; // [..._products] for older flutter version
  }

  Future<void> FetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      _products = [];
      productsSnapshot.docs.forEach((element) {
        print(element.get('productId'));
        _products.insert(0, Product(
            id: element.get('productId'),
            title: element.get('productTitle'),
            description:
            element.get('productDescription'),
        price: double.parse(
        element.get('price'),
        ),
            imageUrl:
            element.get('productImage'),
            brand: element.get('productBrand'),
            productCategoryName: element.get('productCategory'),
            quantity: int.parse(
              element.get('quantity'),
            ),
            isPopular: element.get('isPopular') == "True" ? true : false
            //isPopular: false,
        ),);
      });
    });
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> findByCategory(String categoryName) {
    List<Product> _categoryList = _products
        .where((element) =>
        element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> findByBrand(String brandName) {
    List<Product> _searchList = _products
        .where((element) =>
        element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return _searchList;
  }

  List<Product> searchQuery(String searchText) {
    List<Product> _categoryList = _products
        .where((element) =>
        element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _categoryList;
  }

}