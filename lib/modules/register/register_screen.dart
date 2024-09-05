import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/components/text_field.dart';
import 'package:page_view/components/toast.dart';
import 'package:page_view/models/register_user.dart';
import 'package:page_view/modules/login/login_screen.dart';
import 'package:page_view/modules/register/cubit/cubit.dart';
import 'package:page_view/utils/image_src.dart';
import 'package:page_view/modules/register/cubit/states.dart';
import 'package:page_view/utils/form_validator.dart';
import 'package:page_view/utils/up_clipper.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final FormValidator myFormValidator = FormValidator();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterScreenCubit(),
      child: BlocConsumer<RegisterScreenCubit, RegisterScreenStates>(
          listener: (context, state) {
        if (state is RegisterScreenErrorRegisterState) {
          showToast(message: state.error, state: ToastState.ERROR);
        }
      }, builder: (context, state) {
        var cubit = RegisterScreenCubit.getCubit(context);

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    ClipPath(
                      clipper: UpRegisterClipper(),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
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
                            'Join, Explore, Rate and Shop',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                backgroundImage: (cubit.image == null)
                                    ? null
                                    : FileImage(cubit.image!),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getImage(MyImageSource.camera);
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
                                            fontFamily: 'Tiems New Roman',
                                            fontSize: 12,
                                            color: Colors.blue.shade700,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getImage(MyImageSource.gallery);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.browse_gallery,
                                      color: Colors.blue.shade700,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Gallery',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontFamily: 'Tiems New Roman',
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
                              sufIcon: cubit.isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: !cubit.isVisible,
                              sufPressed: () {
                                cubit.changePasswordVisibility();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          FilledButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit
                                    .registerUser(RegisterUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ))
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                          settings: RouteSettings(arguments: {
                                            'email': emailController.text,
                                            'password': passwordController.text,
                                          })),
                                      (route) => false);
                                }).catchError((error) {});
                              }
                            },
                            child: const Text('Register'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already a Member!',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                child: const Text('Login'),
                                onPressed: () {
                                  MyNavigator.navigateAndRemove(
                                      screen: LoginScreen(), context: context);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
