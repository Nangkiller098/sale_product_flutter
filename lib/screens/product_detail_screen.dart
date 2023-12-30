import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sale_product_flutter/models/response/Products.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {
  Products? products;
  ProductDetailScreen({super.key, this.products});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Prodct detail"),
      ),
      body: ListView(
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
                items: widget.products!.images!
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
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Text(
              "${widget.products!.title}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("brand"),
                  Text(" ${widget.products!.brand}")
                ]),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Category"),
                  Text(" ${widget.products!.category}")
                ]),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Price"),
                  Text("\$ ${widget.products!.price}")
                ]),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Stock"),
                  Text("${widget.products!.stock}")
                ]),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Rating"),
                  Text("${widget.products!.rating}")
                ]),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Text("${widget.products!.description}"),
          )
        ],
      ),
    );
  }
}
