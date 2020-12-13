import 'package:flutter/material.dart';
import '../models/data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _list = [];
  final _token;
  final _userId;

  Products(this._token, this._userId, this._list);

  Future<void> addProduct(Product product) async {
    try {
      final url =
          "https://curesdokan-5b82e-default-rtdb.firebaseio.com/curesdokan.json?auth=$_token";
      var respose = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));

      if (respose.statusCode == 200) {
        print(respose.body);

        Product _newProduct = Product(
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          id: json.decode(respose.body)['name'],
          description: product.description,
        );

        _list.add(_newProduct);
      } else {
        print('error request');
      }
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> fetchProduct() async {
    List<Product> temp = [];
    final url =
        "https://curesdokan-5b82e-default-rtdb.firebaseio.com/curesdokan.json?auth=$_token";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final extertedData = json.decode(response.body) as Map<String, dynamic>;
      final favUrl =
          "https://curesdokan-5b82e-default-rtdb.firebaseio.com/Userfavorite/$_userId.json?auth=$_token";
      final favResponse =
          await http.get(favUrl).catchError((error) => print(error));
      final favData = json.decode(favResponse.body);

      extertedData.forEach((productId, productData) {
        temp.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: favData==null?false:favData[productId] ?? false,
        ));
      });
    }
    _list = temp;
    notifyListeners();
  }

  deleteProduct(String id) {
    final url =
        "https://curesdokan-5b82e-default-rtdb.firebaseio.com/curesdokan/$id.json?auth=$_token";

    final index = _list.indexWhere((element) => element.id == id);
    var existingProduct = _list[index];
    http.delete(url).catchError((_) {
      _list[index] = existingProduct;
    });
    _list.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product product) async {
    final url =
        "https://curesdokan-5b82e-default-rtdb.firebaseio.com/curesdokan/$id.json?auth=$_token";

    final index = _list.indexWhere((element) => element.id == id);
    await http.patch(url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }));
    _list[index] = product;
    notifyListeners();
  }

  List<Product> get productList {
    return [..._list];
  }

  List<Product> get favProductList {
    return _list.where((element) => element.isFavorite).toList();
  }
}
