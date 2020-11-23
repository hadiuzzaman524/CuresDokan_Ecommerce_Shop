import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add products'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
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
                              setState(() {
                              });
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
