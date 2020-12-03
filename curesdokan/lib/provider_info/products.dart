import 'package:flutter/material.dart';
import '../models/data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://www.roudstudio.com/images/works/product-photo/img03.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586495777744-4413f21062fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    ),
  ];

  Future<void> addProduct(Product product) async {
    try {
      final url =
          "https://curesdokan-5b82e-default-rtdb.firebaseio.com/curesdokan.json";
      var respose = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
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

  deleteProduct(String id) {
    _list.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  updateProduct(String id, Product product) {
    final index = _list.indexWhere((element) => element.id == id);
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
