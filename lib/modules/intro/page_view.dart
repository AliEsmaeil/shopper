import 'package:flutter/material.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/models/page_model.dart';
import 'package:page_view/modules/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewScreen extends StatelessWidget {

  final pagesList = <PageModel>[
    PageModel(imagePath: 'lib/core/assets/images/shopping.png', title: 'Page 1 Title', body: 'Page 1 Body'),
    PageModel(imagePath: 'lib/core/assets/images/shopping.png', title: 'Page 2 Title', body: 'Page 2 Body'),
    PageModel(imagePath: 'lib/core/assets/images/shopping.png', title: 'Page 3 Title', body: 'Page 3 Body'),

  ];

  PageController controller = PageController();
  int currentIndex = 0 ;

  PageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(AppCubit.isDark ? Icons.light_mode : Icons.dark_mode,),
                onPressed: (){
                  AppCubit.getCubit(context).changeThemeMode();
                },
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              child: const Text('SKIP'),
              onPressed: () {

                submit(context: context , errorMessage: 'error in writing data in shared prefs while skipping on boarding');

              },
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (context, index) => buildPageItem(context, pagesList[index]),
                  physics: const BouncingScrollPhysics(),
                  itemCount: pagesList.length,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index){

                    currentIndex = index;
                  },
            )),

            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: pagesList.length,
                    effect:WormEffect(
                      spacing: 15,
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: Colors.blue.shade100,
                      activeDotColor: Colors.blue.shade700,

                    )
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: (){

                      currentIndex++;
                      if(currentIndex == pagesList.length)
                      {
                        submit(context: context, errorMessage: 'error in navigation to login from FAB');

                      }
                      else {
                        controller.animateToPage(
                          currentIndex,
                          duration: const Duration(seconds: 1),
                          curve: Curves.ease,
                        );
                      }
                    },
                    backgroundColor: Colors.blue.shade400,
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildPageItem(BuildContext context, PageModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 80,),
        Image.asset(
          model.imagePath,
        ),
        const SizedBox(height: 30,),
        Text(
          model.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          model.body,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
void submit({String? errorMessage, required BuildContext context}){

  SharedPrefHelper.writeData(key: SharedPreferenceConstants.isFirstRun, value: false)
      .then((value) {
    if(value){
      MyNavigator.navigateAndRemove(screen: LoginScreen(), context: context);
    }
  }).catchError((error){
    debugPrint(errorMessage);
  });
}