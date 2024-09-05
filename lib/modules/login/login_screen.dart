import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/components/text_field.dart';
import 'package:page_view/components/toast.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/modules/home/home_page.dart';
import 'package:page_view/modules/login/cubit/cubit.dart';
import 'package:page_view/modules/login/cubit/states.dart';
import 'package:page_view/modules/register/register_screen.dart';
import 'package:page_view/utils/up_clipper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            if (state.response.status) {
              // existing user
              showToast(
                message: state.response.message,
                state: ToastState.SUCCESS,
              );
              SharedPrefHelper.writeData(
                  key: SharedPreferenceConstants.userData,
                  value: [
                    state.response.data!.name,
                    state.response.data!.email
                  ]);
              SharedPrefHelper.writeData(
                      key: SharedPreferenceConstants.token,
                      value: state.response.data?.token)
                  .then((value) {
                if (value) {
                  MyNavigator.navigateAndRemove(
                      screen: HomeScreen(), context: context);
                }
              }).catchError((error) {
                debugPrint('error on exist user login');
              });
            } else {
              // user doesn't exist

              showToast(
                message: state.response.message,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.getCubit(context);
          var map = <String, dynamic>{'email': '', 'password': ''};

          if (ModalRoute.of(context)?.settings.arguments != null) {
            map = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>;
          }
          emailController.text =
              map['email'].isEmpty ? emailController.text : map['email'];
          passwordController.text = map['password'].isEmpty
              ? passwordController.text
              : map['password'];

          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: UpLoginClipper(),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 25),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'login to explore our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey.shade500,
                                  ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            defaultTextField(
                              controller: emailController,
                              validator: (String? s) =>
                                  s!.isEmpty ? 'Email is Empty!' : null,
                              context: context,
                              label: 'Email',
                              preIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextField(
                              controller: passwordController,
                              validator: (String? s) =>
                                  s!.isEmpty ? 'Password is Empty!' : null,
                              context: context,
                              label: 'Password',
                              preIcon: Icons.lock_outlined,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.go,
                              sufIcon: cubit.isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              isPassword: !cubit.isVisible,
                              sufPressed: () {
                                if (passwordController.text.isNotEmpty) {
                                  cubit.changeVisibility();
                                }
                              },
                              onSubmitted: (v) {
                                if (formKey.currentState!.validate()) {
                                  cubit.login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoadingLoginState,
                              builder: (context) => FilledButton(
                                child: const Text('Login'),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              ),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not a Member?',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                TextButton(
                                  onPressed: () {
                                    MyNavigator.navigateAndRemove(
                                        screen: RegisterScreen(),
                                        context: context);
                                  },
                                  child: const Text('Register'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
