import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sale_product_flutter/components/loading_component.dart';
import 'package:sale_product_flutter/models/response/Products.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {
  Products? products;
  ProductDetailScreen({super.key, this.products});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Products product = Products();
  // ignore: non_constant_identifier_names
  GetProductById(int id) async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("https://dummyjson.com/products/${id.toString()}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      product = Products.fromJson(map);
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    GetProductById(widget.products!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Prodct detail"),
      ),
      body: isLoading == true
          ? const LoadingComponent()
          : RefreshIndicator(
              onRefresh: () async {
                GetProductById(widget.products!.id!);
              },
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.teal,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.teal,
                      child: CarouselSlider(
                        options: CarouselOptions(),
                        items: product.images!
                            .map(
                              (item) => Center(
                                  child: Image.network(item,
                                      fit: BoxFit.cover, width: 1000)),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Text(
                      "${product.title}",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("brand"),
                          Text(" ${product.brand}")
                        ]),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Category"),
                          Text(" ${product.category}")
                        ]),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Price"),
                          Text("\$ ${product.price}")
                        ]),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Stock"),
                          Text("${product.stock}")
                        ]),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Rating"),
                          Text("${product.rating}")
                        ]),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Text("${product.description}"),
                  )
                ],
              ),
            ),
    );
  }
}
