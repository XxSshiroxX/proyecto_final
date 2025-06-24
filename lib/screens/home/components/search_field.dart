import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../services/products_service.dart';
import '../../../models/Product.dart';
import '../../products/products_screen.dart';
import "package:proyecto_final/screens/details/details_screen.dart";

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  List<Product> _searchResults = [];
  bool _isLoading = false;
  bool _hasError = false;

  // Método para realizar la búsqueda
  Future<void> _searchProducts(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
        _hasError = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final results = await ProductService.fetchProducts(false, 3, query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          child: TextFormField(
            controller: _controller,
            onChanged: (value) {
              // Realiza la búsqueda con un retraso para evitar demasiadas consultas
              Future.delayed(const Duration(milliseconds: 300), () {
                if (value == _controller.text) {
                  _searchProducts(value);
                }
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: kSecondaryColor.withAlpha((0.1 * 255).toInt()),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              border: searchOutlineInputBorder,
              focusedBorder: searchOutlineInputBorder,
              enabledBorder: searchOutlineInputBorder,
              hintText: "Buscar producto",
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (_isLoading)
          const Center(
              child: CircularProgressIndicator()), // Indicador de carga
        if (_hasError)
          const Center(
            child: Text(
              'Error al buscar productos.',
              style: TextStyle(color: Colors.red),
            ),
          ),
        if (_searchResults.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                ..._searchResults.map((product) => ListTile(
                      leading: Image.network(
                        product.images.isNotEmpty
                            ? product.images[0]
                            : 'https://via.placeholder.com/150',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image);
                        },
                      ),
                      title: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text("L.${product.price}"),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: ProductDetailsArguments(product: product),
                        );
                      },
                    )),
                const Divider(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ProductsScreen.routeName,
                      arguments: {"search": _controller.text, "bySearch": true},
                    );
                  },
                  child: const Text("Mostrar más"),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);
