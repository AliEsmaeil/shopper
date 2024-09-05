import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/drawer.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/modules/faqs/cubit/cubit.dart';
import 'package:page_view/modules/faqs/cubit/states.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqsScreenCubit(),
      child: BlocConsumer<FaqsScreenCubit, FaqsScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FaqsScreenCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Frequently Asked Questions'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      AppCubit.isDark ? Icons.light_mode : Icons.dark_mode,
                    ),
                    onPressed: () {
                      AppCubit.getCubit(context).changeThemeMode();
                    },
                  ),
                )
              ],
            ),
            drawer: const MyDrawer(),
            body: ConditionalBuilder(
              condition: cubit.faqs.isNotEmpty,
              builder: (context) {
                return ListView.builder(
                  itemCount: cubit.faqs.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(
                        cubit.faqs[index].question,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      backgroundColor: Colors.grey.shade300,
                      childrenPadding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tilePadding: const EdgeInsets.all(5),
                      children: [
                        Text(
                          cubit.faqs[index].answer,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                );
              },
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue.shade700,
                    strokeWidth: 1,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
