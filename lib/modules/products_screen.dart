import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/carousel_slider.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/models/category_model.dart';
import 'package:page_view/models/home_data.dart';
import 'package:page_view/modules/home/cubit/cubit.dart';
import 'package:page_view/modules/home/cubit/states.dart';
import 'package:page_view/modules/product_description.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomePageCubit.getCubit(context);
          return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoryModel != null,
            builder: (context) => ListView(
              children: [
                Column(
                  children: [
                    CustomCarouselSlider(
                      items: cubit.homeModel?.data.banners
                          .map((e) => Material(
                                elevation: 5,
                                shadowColor: Colors.black,
                                child: Image.network(
                                  e.image,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          .toList() as List<Widget>,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text('Categories',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 20,
                                )),

                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount: cubit.categoryModel?.data.data.length,
                        itemBuilder: (context, index) => buildCategoryItem(
                            cubit.categoryModel!.data.data[index], context),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),

                    Text(
                      'New Products',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 20,
                          ),
                    ), // text

                    Container(
                      color: AppCubit.isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade200,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 2
                              : 4,
                          childAspectRatio: 1 / 1.4,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                        ),
                        itemBuilder: (context, index) => buildGridItem(
                            cubit.homeModel!.data.products[index], context),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.homeModel!.data.products.length,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade700,
                strokeWidth: 1,
              ),
            ),
          );
        });
  }

  Widget buildGridItem(Product product, BuildContext context) {
    return Material(
      color: AppCubit.isDark ? Colors.black : Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const ProductDescription(),
                settings: RouteSettings(
                  arguments: product,
                )),
          );
        },
        highlightColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                    product.image,
                    height: 130,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                  if (product.discount > 0)
                    const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        backgroundColor: Colors.red,
                        fontSize: 8,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    '${product.price}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'Times New Roman',
                          color: Colors.blue.shade700,
                        ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  if (product.discount > 0)
                    Text(
                      '${product.oldPrice}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: Colors.red,
                            fontFamily: 'Times New Roman',
                          ),
                    ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                        (HomePageCubit.getCubit(context)
                                .localFavorites[product.id]!)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: (HomePageCubit.getCubit(context)
                                    .localFavorites[product.id] ??
                                false)
                            ? Colors.red
                            : Colors.grey),
                    onPressed: () {
                      HomePageCubit.getCubit(context)
                          .changeFavoriteProduct(product.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryItem(Category category, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          border: const Border.fromBorderSide(
              BorderSide(color: Colors.black, width: 1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.network(
                    category.image,
                    width: double.infinity,
                  ),
                  Container(
                    height: 20,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(category.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
