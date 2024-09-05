import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/models/home_data.dart';
import 'package:page_view/modules/home/cubit/cubit.dart';
import 'package:page_view/modules/home/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomePageCubit.getCubit(context);

          return ConditionalBuilder(
              condition: cubit.localFavorites.containsValue(true),
              builder: (context) => ListView.builder(
                    itemBuilder: (context, index) {
                      if (cubit.localFavorites[
                          cubit.homeModel!.data.products[index].id]!) {
                        return buildFavItem(
                            cubit.homeModel!.data.products[index], context);
                      }
                      return const SizedBox.shrink();
                    },
                    itemCount: cubit.homeModel!.data.products.length,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                  ),
              fallback: (context) => const Center(
                    child: Text('No Favs yet.'),
                  ));
        });
  }

  Widget buildFavItem(Product favItem, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Dismissible(
          onDismissed: (direction) {
            HomePageCubit.getCubit(context).changeFavoriteProduct(favItem.id);
            //  HomePageCubit.getCubit(context).getUserFavorites();
          },
          movementDuration: const Duration(seconds: 5),
          resizeDuration: const Duration(seconds: 1),
          key: UniqueKey(),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
                color: AppCubit.isDark ? Colors.black : Colors.white,
                border: Border(
                    bottom: BorderSide(
                  color: AppCubit.isDark
                      ? Colors.grey.shade700
                      : Colors.grey.shade200,
                  width: .5,
                ))),
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.network(
                      favItem.image,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                    if (favItem.discount > 0)
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
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          favItem.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${favItem.price}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.blue.shade700,
                                      fontFamily: 'Times New Roman',
                                    ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          if (favItem.discount > 0)
                            Text(
                              '${favItem.oldPrice}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontFamily: 'Times New Roman',
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                  ),
                            ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              HomePageCubit.getCubit(context)
                                  .changeFavoriteProduct(favItem.id);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
