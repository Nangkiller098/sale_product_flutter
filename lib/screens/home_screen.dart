import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sale_product_flutter/components/loading_component.dart';
import 'package:sale_product_flutter/models/response/Products.dart';
import 'package:http/http.dart' as http;
import 'package:sale_product_flutter/screens/product_category_screen.dart';
import 'package:sale_product_flutter/screens/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Products> productList = [];
  List<String> categories = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllCategories();
    getAllProduct();
  }

  getAllProduct() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("https://dummyjson.com/products");
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

  getAllCategories() async {
    var url = Uri.parse("https://dummyjson.com/products/categories");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      map.forEach((data) {
        categories.add("$data");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Sale App",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: isLoading == true
          ? const LoadingComponent()
          : RefreshIndicator(
              onRefresh: () async {
                getAllCategories();
                getAllProduct();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductCategoryScreen(
                                                categoryName:
                                                    categories[index])));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Text(
                                  categories[index],
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productList.length,
                        itemBuilder: (BuildContext context, index) {
                          var product = productList[index];
                          return Container(
                            margin: const EdgeInsets.only(top: 5),
                            decoration:
                                const BoxDecoration(color: Colors.black12),
                            child: ListTile(
                              onTap: () {
                                // print("PRODUCT ID ${product.id}");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
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
                  ],
                ),
              ),
            ),
    );
  }
}
