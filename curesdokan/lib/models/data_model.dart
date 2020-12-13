import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../provider_info/products.dart';
import 'dart:convert';

class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFav(String _token,String userId) async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        "https://curesdokan-5b82e-default-rtdb.firebaseio.com/Userfavorite/$userId/$id.json?auth=$_token";
    await http.put(
      url,
      body: json.encode(
          isFavorite,
      ),
    ).catchError((error){
      isFavorite=oldStatus;
    });

  }
}
