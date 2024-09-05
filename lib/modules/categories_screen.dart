import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/models/category_model.dart';
import 'package:page_view/modules/home/cubit/cubit.dart';
import 'package:page_view/modules/home/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomePageCubit.getCubit(context);

          return ListView.builder(
            itemBuilder: (context, index) =>
                buildCategoryItem(cubit.categoryModel!.data.data[index]),
            itemCount: cubit.categoryModel!.data.data.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
          );
        });
  }

  buildCategoryItem(Category category) {
    return Card(
      borderOnForeground: false,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Image.network(
                  category.image,
                  height: 120,
                ),
                Text(
                  category.name,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
