import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/drawer.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/components/text_field.dart';
import 'package:page_view/components/toast.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/modules/account/account_screen.dart';
import 'package:page_view/modules/account/update_account/cubit/cubit.dart';
import 'package:page_view/modules/account/update_account/cubit/states.dart';
import 'package:page_view/utils/form_validator.dart';
import 'package:page_view/utils/image_src.dart';
import 'package:page_view/utils/up_clipper.dart';

class UpdateAccountScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final myFormValidator = FormValidator();

  final formKey = GlobalKey<FormState>();

  UpdateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateAccountCubit(),
      child: BlocConsumer<UpdateAccountCubit, UpdateAccountScreenStates>(
        listener: (context, state) {
          if (state is UpdateAccountSuccessState) {
            showToast(message: state.message, state: ToastState.SUCCESS);
            Future.delayed(const Duration(seconds: 2), () {
              MyNavigator.navigateTo(screen: AccountScreen(), context: context);
            });
          }
          if (state is UpdateAccountErrorState) {
            showToast(message: state.message, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = UpdateAccountCubit.getCubit(context);

          return Scaffold(
            appBar: AppBar(
                title: const Text('Update Account'),
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
                systemOverlayStyle:
                    Theme.of(context).appBarTheme.systemOverlayStyle?.copyWith(
                          systemNavigationBarColor:
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? Colors.blue.shade900
                                  : Colors.white,
                        )),
            drawer: const MyDrawer(),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: (cubit.image == null)
                                      ? null
                                      : FileImage(cubit.image!),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cubit.pickImage(MyImageSource.camera);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        color: Colors.blue.shade700,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Camera',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontFamily: 'TimesNewRoman',
                                              fontSize: 12,
                                              color: Colors.blue.shade700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cubit.pickImage(MyImageSource.gallery);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.browse_gallery,
                                          color: Colors.blue.shade700),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Gallery',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontFamily: 'TimesNewRoman',
                                              fontSize: 12,
                                              color: Colors.blue.shade700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextField(
                              controller: nameController,
                              validator: myFormValidator.nameValidator,
                              context: context,
                              label: 'Name',
                              preIcon: Icons.person,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextField(
                              controller: phoneController,
                              validator: myFormValidator.phoneValidator,
                              context: context,
                              label: 'Phone',
                              preIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextField(
                              controller: emailController,
                              validator: myFormValidator.emailValidator,
                              context: context,
                              label: 'Email',
                              preIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextField(
                                controller: passwordController,
                                validator: myFormValidator.passwordValidator,
                                context: context,
                                label: 'Password',
                                preIcon: Icons.lock,
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.visiblePassword,
                                sufIcon: cubit.passwordVisibility
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                isPassword: !cubit.passwordVisibility,
                                sufPressed: () {
                                  cubit.changePasswordVisibility();
                                }),
                            const SizedBox(
                              height: 40,
                            ),
                            ConditionalBuilder(
                                condition: state is! UpdateAccountLoadingState,
                                builder: (context) => FilledButton(
                                      child: const Text('Update'),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.updateAccount(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                    ),
                                fallback: (context) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue.shade700,
                                        strokeWidth: 1,
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ClipPath(
                  clipper: UpdateAccountClipper(),
                  child: Container(
                    height: 100,
                    color: Colors.blue.shade900,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
