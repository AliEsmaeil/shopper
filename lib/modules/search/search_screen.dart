import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/text_field.dart';
import 'package:page_view/modules/search/cubit/cubit.dart';
import 'package:page_view/modules/search/cubit/states.dart';
import 'package:page_view/modules/search/search_item.dart';

class SearchScreen extends StatelessWidget {

  final searchController = TextEditingController();
   SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> SearchCubit(),

      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder:(context,state){

          var cubit = SearchCubit.getCubit(context);

          return SafeArea(
            minimum: const EdgeInsets.only(top:10),
              child: Scaffold(
                body: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    defaultTextField(
                      controller: searchController,
                      validator: (s)=>(s!.isEmpty)? 'Enter a Key Word' : null,
                      context: context,
                      label: 'Search',
                      preIcon: Icons.search,
                      textInputAction: TextInputAction.go,
                      onChanged: (word){
                          cubit.search(word);
                      },
                      autoFocus: true,
                    ),
                    if(state is LoadingSearchState)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(color: Colors.blue.shade700,minHeight: 2,),
                    ),
                    const SizedBox(height: 20,),
                    ConditionalBuilder(
                        condition: (state is SuccessSearchState),
                        builder:(context){
                          if(cubit.searchData!.products.isNotEmpty){
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.searchData?.products.length,
                              itemBuilder: (context,index)=> SearchItemBuilder(product: cubit.searchData!.products[index]),
                            );
                          }
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: Text(
                                  'No Products Found.',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          );
                        },
                        fallback: (context)=>const SizedBox.shrink()
                    )
                  ],
                ),
              ));

        },
      ),
    );
  }
}
