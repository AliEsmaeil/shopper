import 'package:flutter/material.dart';
import 'package:page_view/components/account_header.dart';
import 'package:page_view/components/dialog.dart';
import 'package:page_view/components/drawer.dart';
import 'package:page_view/components/list_tile.dart';
import 'package:page_view/components/navigator.dart';
import 'package:page_view/cubit/cubit.dart';
import 'package:page_view/models/login_model.dart';
import 'package:page_view/modules/account/change_password/change_password.dart';
import 'package:page_view/modules/account/cubit/cubit.dart';
import 'package:page_view/modules/account/update_account/updateScreen.dart';
import 'package:page_view/utils/up_clipper.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        systemOverlayStyle:
            Theme.of(context).appBarTheme.systemOverlayStyle!.copyWith(
                  systemNavigationBarColor:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? Colors.blue.shade900
                          : Colors.white,
                ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FutureBuilder<UserData>(
                      future: AccountScreenFuture().getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Column(
                            children: [
                              const AccountHeader(),
                              ListTile(
                                leading: Text(
                                  'Phone',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                               title: Text(
                                  snapshot.data!.phone,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: const Icon(Icons.phone_enabled),
                              ),
                              ListTile(
                                leading: Text(
                                  'Points',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              title : Text(
                                  '${snapshot.data!.points}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: const Icon(Icons.generating_tokens),
                              ),
                              ListTile(
                                leading: Text(
                                  'Credit',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                            title: Text(
                                  '${snapshot.data!.credit}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: const Icon(Icons.credit_card),
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 5,
                                thickness: .5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomListTile(
                                  listTitle: const Text('Update Profile'),
                                  sufIcon: const Icon(Icons.update),
                                  onTap: () {
                                    MyNavigator.navigateTo(
                                        screen: UpdateAccountScreen(),
                                        context: context);
                                  }),
                              CustomListTile(
                                  listTitle: const Text('Change Password'),
                                  sufIcon: const Icon(Icons.change_circle),
                                  onTap: () {
                                    MyNavigator.navigateTo(
                                        screen: ChangePasswordScreen(),
                                        context: context);
                                  }),
                              CustomListTile(
                                  listTitle: const Text('Log out'),
                                  sufIcon: const Icon(Icons.logout_outlined),
                                  onTap: () {
                                    MyNavigator.signOut(context);
                                  }),
                              CustomListTile(
                                  listTitle: const Text('Delete Account'),
                                  sufIcon: const Icon(Icons.delete_forever),
                                  onTap: () async {
                                    if (await getDialog(context)) {
                                      MyNavigator.signOut(context); //  the api doesn't provide account delete functionality
                                      // although, it can be handled locally, to prevent ex users from being logged in with their email
                                      // after deletion, but it's expensive to store all of their data in sqlite database while working
                                      // with api and using shared preferences (makes it heavy app).
                                    }
                                  }),
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade700,
                            strokeWidth: 1,
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          ClipPath(
            clipper: DownAccountClipper(),
            child: Container(
              color: Colors.blue.shade900,
              height: 100,
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
