import 'dart:ffi';

import 'package:flutter/material.dart';
import '../provider_info/products.dart';
import '../models/data_model.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '\editproductscreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final imageController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Product _existingProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void dispose() {
    super.dispose();

    _imageFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    imageController.dispose();
  }

  _saveForm() {
    _formkey.currentState.save();
    print(_existingProduct.title);
    print(_existingProduct.price);
    print(_existingProduct.description);

  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add products'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    onSaved: (value) {
                      _existingProduct = Product(
                        title: value,
                        price: _existingProduct.price,
                        id: _existingProduct.id,
                        imageUrl: _existingProduct.imageUrl,
                        description: _existingProduct.description,
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Price',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
                    onSaved: (value) {
                      _existingProduct = Product(
                        title: _existingProduct.title,
                        price: double.parse(value),
                        id: _existingProduct.id,
                        imageUrl: _existingProduct.imageUrl,
                        description: _existingProduct.description,
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    focusNode: _descriptionFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_imageFocus);
                    },
                    onSaved: (value) {
                      _existingProduct = Product(
                        title: _existingProduct.title,
                        price: _existingProduct.price,
                        id: _existingProduct.id,
                        imageUrl: _existingProduct.imageUrl,
                        description: value,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: imageController.text.isEmpty
                              ? Center(child: Text('Enter Url'))
                              : Image.network(
                                  imageController.text.toString(),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Image Url',
                            ),
                            keyboardType: TextInputType.url,
                            focusNode: _imageFocus,
                            controller: imageController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _existingProduct = Product(
                                title: _existingProduct.title,
                                price: _existingProduct.price,
                                id: _existingProduct.id,
                                imageUrl: value,
                                description: _existingProduct.description,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
