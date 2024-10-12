import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart'; // Import your model

class ApiService {
  final String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
