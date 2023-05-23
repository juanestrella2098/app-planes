import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_app/pages/filtros_pages/filter_page.dart';
import 'package:plan_app/pages/favs_pages/favs_page.dart';
import 'package:plan_app/pages/logged_pages/user_pages/user_page.dart';
import 'package:plan_app/providers/filtro_providers.dart';
import 'package:plan_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool flag = false;
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 1;
  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.favorite_border_sharp,
      "Favoritos",
      Colors.grey[700]!,
      labelStyle: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.search_sharp,
      "Explora",
      Colors.grey[700]!,
      labelStyle: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.person_sharp,
      "Perfil",
      Colors.grey[700]!,
      labelStyle:
          TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            child: bodyContainer(),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    if (_selectedIndex == 0) return FavsPage();
    if (_selectedIndex == 1) return FilterPage();
    if (_selectedIndex == 2) return UserPage();

    return Container();
  }

  Widget bottomNav() {
    final userProvider = Provider.of<UserProvider>(context);
    final filtroProvider = Provider.of<FiltroProviders>(context);
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: _selectedIndex,
      barHeight: bottomNavBarHeight,
      // use either barBackgroundColor or barBackgroundGradient to have a gradient on bar background
      barBackgroundColor: Colors.white,
      // barBackgroundGradient: LinearGradient(
      //   begin: Alignment.bottomCenter,
      //   end: Alignment.topCenter,
      //   colors: [
      //     Colors.blue,
      //     Colors.red,
      //   ],
      // ),
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) async {
        if (flag == false) {
          await userProvider.usuarioRegistrado(user.uid);
          flag = true;
        }
        if (selectedPos == 0) {
          await userProvider.getPlanesFavs();
        }
        setState(() {
          filtroProvider.reseteProvider();
          _selectedIndex = selectedPos ?? 0;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}