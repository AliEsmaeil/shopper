import 'package:flutter/material.dart';
import 'package:page_view/models/home_data.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)?.settings.arguments as Product;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                product.name,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              height: 250,
              child: Image.network(product.image),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: product.images.length,
                itemBuilder: (context, index) => SizedBox(
                  width: 200,
                  child: Image.network(product.images[index]),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    product.price.toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'TimesNewRoman',
                          color: Colors.blue.shade700,
                        ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: product.inFavorites ? Colors.red : Colors.grey,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: .5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Product Description',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'TimesNewRoman', fontWeight: FontWeight.w500),
              ),
            ),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
