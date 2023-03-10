import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'configs/config.dart';

import 'providers/auth_provider.dart';
import 'screens/check_auth.dart';
import 'screens/onboarding_screen.dart';
import 'screens/register_acc_screen.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';
import 'providers/groceries_lists_provider.dart';
import 'providers/products_provider.dart';
import 'providers/orders_provider.dart';
import 'screens/categories_screen.dart';
import 'screens/category_products_screen.dart';
import 'screens/list_form_screen.dart';
import '../screens/list_details_screen.dart';
import 'screens/login_screen.dart';
import 'screens/order_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/search_results_screen.dart';

void main() async {
  await initConfiguration();
  final prefs = await SharedPreferences.getInstance();
  var isFirstTime = prefs.getBool("firstTimeAppUsage");
  if (isFirstTime == null) {
    isFirstTime = true;
    prefs.setBool("firstTimeAppUsage", true);
  }

  runApp(MyApp(isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool? isFirstTime;

  const MyApp(this.isFirstTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductsProvider>(
            create: (_) => ProductsProvider(),
          ),
          ChangeNotifierProvider<GroceriesListsProvider>(
              create: (_) => GroceriesListsProvider()),
          ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
          ChangeNotifierProvider<OrdersProvider>(
            create: (_) => OrdersProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider())
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [Locale('pt', 'BR')],
          debugShowCheckedModeBanner: false,
          title: "Vish-virtual shop",
          initialRoute:
              isFirstTime! ? "/onboarding-screen" : "/check-auth-screen",
          theme: Theme.of(context).copyWith(
              primaryColor: const Color(0xFFf65c05),
              textTheme: const TextTheme(
                  headline4: TextStyle(
                      fontSize: 30, color: Colors.black, fontFamily: "Acme"),
                  headline2: TextStyle(
                    fontSize: 14,
                    fontFamily: "Acme",
                    color: Colors.black,
                  ),
                  headline1: TextStyle(
                      fontSize: 12, fontFamily: "Acme", color: Colors.grey))),
          routes: {
            "/onboarding-screen": ((context) => const OnboardingScreen()),
            "/login-screen": (context) => const LoginScreen(),
            "/register-screen": (context) => const RegisterAccountScreen(),
            "/home-screen": (context) => const HomeScreen(),
            "/search-results": (context) => const SearchResultsScreen(),
            "/categorias": (context) => const CategoriesScreen(),
            "/categoria-produtos": (context) => const CategoryProductsScreen(),
            "/detalhe-produto": (context) => const ProductDetailScreen(),
            "/lista-form": (context) => const ListFormScreen(),
            "/lista-detalhes": (context) => const ListDetailsScreen(),
            "/order-screen": (context) => const OrderScreen(),
            "/cart-screen": (context) => const CartScreen(),
            "/check-auth-screen": (context) => const CheckAuth()
          },
        ));
  }
}
