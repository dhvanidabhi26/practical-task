import 'package:flutter/material.dart';
import 'package:flutter_application_2/api.dart';
import 'product_model.dart'; // Import your model

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.amber,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(product.title ?? 'No Title',style: const TextStyle(color:  Colors.white,fontWeight: FontWeight.w600),),
                  subtitle: Text('\$${product.price?.toStringAsFixed(2)}',style: const TextStyle(color:  Colors.black,fontWeight: FontWeight.w300),),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(product.image ?? '', width: 80,height: 120,fit: BoxFit.cover,)),
                  isThreeLine: true,
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rating: ${product.rating?.rate ?? 'N/A'}',style: const TextStyle(color:  Colors.black,fontWeight: FontWeight.w300),),
                      Text('(${product.rating?.count ?? 0})',style: const TextStyle(color:  Colors.black,fontWeight: FontWeight.w300),),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
