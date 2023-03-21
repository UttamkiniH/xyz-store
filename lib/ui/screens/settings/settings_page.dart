import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/common/app_colors.dart';
import 'package:xyz_store/providers/theme_provider.dart';
import 'package:xyz_store/ui/screens/get_started_page.dart';
import 'package:xyz_store/ui/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: CustomAppBar(textString: "Settings"),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const ListTile(
                // tileColor: Colors.red,
                leading: Icon(
                  Icons.account_circle_rounded,
                  size: 40,
                ),
                title: Text("User"),
                subtitle: Text("we@gmail.com"),
              ),
              Divider(
                thickness: 2,
                color: GlobalColors().primaryRed,
              ),
              ListTile(
                  title: Text(tr("dark_theme_toggle")),
                  trailing: Switch(
                      activeColor: GlobalColors().primaryRed,
                      value: themeProvider.darkTheme,
                      onChanged: ((value) {
                        themeProvider.darkTheme = !themeProvider.darkTheme;
                      }))),
              ListTile(
                title: Text(tr("my_orders")),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text(tr('address_book')),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ),
              ExpansionTile(
                title: Text(tr('select_language')),
                controlAffinity: ListTileControlAffinity.trailing,
                children: [
                  ListTile(
                    onTap: () {
                      context.setLocale(const Locale("en"));
                    },
                    title: const Text("English"),
                  ),
                  ListTile(
                    onTap: () {
                      context.setLocale(const Locale("hi"));
                    },
                    title: const Text("Hindi"),
                  ),
                  ListTile(
                    onTap: (() {
                      context.setLocale(const Locale('kn'));
                    }),
                    title: const Text("Kannada"),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const GetStartedPage())));
                  },
                  child: SizedBox(
                    child: Text(
                      tr("log_out"),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )),
            ],
          ),
        ));
  }
}
