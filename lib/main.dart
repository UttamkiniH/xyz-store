import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:xyz_store/config/app_router.dart';
import 'package:xyz_store/firebase_options.dart';
import 'package:xyz_store/providers/checkout_provider.dart';
import 'package:xyz_store/providers/products_provider.dart';
import 'package:xyz_store/providers/theme_provider.dart';
import 'package:xyz_store/services/firebase_auth_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
    path: 'assets/translations',
    startLocale: const Locale('en'),
    supportedLocales: const [Locale('en'), Locale('hi'), Locale('kn')],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMedthods>(
          create: (_) => FirebaseAuthMedthods(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider<FetchOrderProvider>(
          create: (context) => FetchOrderProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
            create: ((context) => ProductProvider())),
        ChangeNotifierProvider(create: ((context) => FetchLocationProvider())),
        StreamProvider(
            create: ((context) =>
                context.read<FirebaseAuthMedthods>().authState),
            initialData: null)
      ],
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          darkTheme: appDarkTheme,
          theme: appLightThme,
          debugShowCheckedModeBanner: false,
          themeMode: provider.darkTheme ? ThemeMode.dark : ThemeMode.light,
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}
