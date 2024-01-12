import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter_amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter_amazon_clone/models/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
        showSnackBar(context, 'Product deleted!');
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddproductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6).copyWith(top: 10),
              child: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(
                          imageUrl: productData.images[0],
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            },
                            icon: const Icon(Icons.delete_outline),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip: 'Add a product',
              child: const Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
