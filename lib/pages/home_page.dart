import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio _dio = Dio();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData({String? searchText}) async {
    String url = "https://freetestapi.com/api/v1/products";
    if (searchText != null && searchText.isNotEmpty) {
      url += "?search=$searchText";
    }

    try {
      Response res = await _dio.get(url);
      List<Product> products = [];
      if (res.data != null) {
        for (var p in res.data) {
          products.add(Product.fromJson(p));
        }
      }
      setState(() {
        _products = products;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Search"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        _searchBar(),
        Expanded(
          child: _products.isNotEmpty
              ? _productsListView()
              : const Center(child: Text("No products found.")),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: (value) {
          _loadData(searchText: value);
        },
        decoration: const InputDecoration(
          hintText: "Search...",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _productsListView() {
    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        Product product = _products[index];
        return ListTile(
          title: Text(product.name),
          subtitle:
              Text("${product.brand} - \$${product.price.toStringAsFixed(2)}"),
        );
      },
    );
  }
}
