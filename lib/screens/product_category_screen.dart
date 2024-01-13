import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sale_product_flutter/models/response/Products.dart';
import 'package:http/http.dart' as http;
import 'package:sale_product_flutter/screens/product_detail_screen.dart';

// ignore: must_be_immutable
class ProductCategoryScreen extends StatefulWidget {
  String? categoryName;
  ProductCategoryScreen({super.key, this.categoryName});

  @override
  // ignore: library_private_types_in_public_api
  _ProductCategoryScreenState createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  List<Products> productList = [];
  bool isLoading = false;
  getAllProduct() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(
        "https://dummyjson.com/products/category/${widget.categoryName}");
    var respone = await http.get(url);
    if (respone.statusCode == 200) {
      var map = jsonDecode(respone.body);
      map["products"].forEach((data) {
        var product = Products.fromJson(data);
        productList.add(product);
      });
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.categoryName!.toUpperCase()),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getAllProduct();
        },
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            itemBuilder: (BuildContext context, index) {
              var product = productList[index];
              return Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(color: Colors.black12),
                child: ListTile(
                  onTap: () {
                    // print("PRODUCT ID ${product.id}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                  products: product,
                                )));
                  },
                  leading: Image.network(
                    "${product.thumbnail}",
                    width: 100,
                    height: 150,
                  ),
                  title: Text("${product.title}"),
                  subtitle: Text("${product.description}"),
                ),
              );
            }),
      ),
    );
  }
}
