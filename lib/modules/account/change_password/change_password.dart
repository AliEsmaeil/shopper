import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view/components/account_header.dart';
import 'package:page_view/components/drawer.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/components/text_field.dart';
import 'package:page_view/components/toast.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/modules/account/account_screen.dart';
import 'package:page_view/modules/account/change_password/cubit/cubit.dart';
import 'package:page_view/modules/account/change_password/cubit/states.dart';
import 'package:page_view/utils/form_validator.dart';
import 'package:page_view/utils/up_clipper.dart';

class ChangePasswordScreen extends StatelessWidget {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            showToast(message: state.message, state: ToastState.SUCCESS);
            Future.delayed(const Duration(seconds: 2), () {
              MyNavigator.navigateTo(screen: AccountScreen(), context: context);
            });
          }
          if (state is ChangePasswordErrorState) {
            showToast(message: state.message, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = ChangePasswordCubit.getCubit(context);

          return Scaffold(
            appBar: AppBar(
                title: const Text('Account'),
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
                    Theme.of(context).appBarTheme.systemOverlayStyle!.copyWith(
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
                  padding: const EdgeInsets.all(20),
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const AccountHeader(),
                        const SizedBox(
                          height: 60,
                        ),
                        defaultTextField(
                            controller: oldPasswordController,
                            validator: (s) =>
                                (s!.isEmpty) ? 'Fill Your Old Password' : null,
                            context: context,
                            label: 'Old Password',
                            preIcon: Icons.lock,
                            sufIcon: cubit.oldPasswordVisibility
                                ? Icons.visibility_off
                                : Icons.visibility,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: !cubit.oldPasswordVisibility,
                            sufPressed: () {
                              cubit.changeOldPasswordVisibility();
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            controller: newPasswordController,
                            validator: FormValidator().passwordValidator,
                            context: context,
                            label: 'New Password',
                            preIcon: Icons.lock_reset_outlined,
                            textInputAction: TextInputAction.go,
                            sufIcon: cubit.newPasswordVisibility
                                ? Icons.visibility_off
                                : Icons.visibility,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: !cubit.newPasswordVisibility,
                            sufPressed: () {
                              cubit.changeNewPasswordVisibility();
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                            condition: state is! ChangePasswordLoadingState,
                            builder: (context) => FilledButton(
                                  onPressed: () {
                                    cubit.changePassword(
                                        oldPassword: oldPasswordController.text,
                                        newPassword:
                                            newPasswordController.text);
                                  },
                                  child: const Text('Change'),
                                ),
                            fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blue.shade900,
                                      strokeWidth: 1),
                                )),
                      ],
                    ),
                  ],
                )),
                ClipPath(
                  clipper: DownChangePasswordClipper(),
                  child: Container(
                    height: 100,
                    color: Colors.blue.shade900,
                  ),
                )
              ],
            ),
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }
}
