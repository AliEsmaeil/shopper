import 'package:flutter/material.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/models/home_data.dart';
import 'package:page_view/modules/home/cubit/cubit.dart';
import 'package:page_view/modules/product_description.dart';

class SearchItemBuilder extends StatelessWidget {

   final Product product;
   const SearchItemBuilder({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppCubit.isDark? Colors.black :  Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context)=>const ProductDescription(),
            settings: RouteSettings(
              arguments: product,
            )),
          );
        },
        highlightColor: Colors.grey,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: AppCubit.isDark? Colors.grey.shade700 :  Colors.grey.shade200,
                        width: .5,
                      )
                  )
              ),
              child: Row(
                children: [
                  Image.network(
                    product.image,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${product.price}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.blue.shade700,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(Icons.favorite,color: product.inFavorites? Colors.red: Colors.grey,),
                              onPressed: (){
                                HomePageCubit.getCubit(context).changeFavoriteProduct(product.id);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],

              ),
            ),
          ),
      ),
    );
  }
}
