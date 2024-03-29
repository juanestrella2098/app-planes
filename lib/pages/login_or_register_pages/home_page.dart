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
    final userProvider = Provider.of<UserProvider>(context);
    final filtroProvider = Provider.of<FiltroProviders>(context);
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: bottomNavBarHeight),
                child: bodyContainer(),
              ),
              Align(alignment: Alignment.bottomCenter, child: bottomNav())
            ],
          );
        } else {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: double.infinity,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      (Icons.favorite),
                                      color: (_selectedIndex == 0)
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'Favoritos',
                                      style: TextStyle(
                                          color: (_selectedIndex == 0)
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ]),
                            ),
                          ),
                          onTap: () async {
                            if (flag == false) {
                              await userProvider.usuarioRegistrado(user.uid);
                              flag = true;
                            }
                            await userProvider.getPlanesFavs();
                            _selectedIndex = 0;

                            setState(() {
                              _navigationController.value = 0;
                              filtroProvider.reseteProvider();
                            });
                          },
                        ),
                        GestureDetector(
                          child: SizedBox(
                            width: 70,
                            height: double.infinity,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      (Icons.search),
                                      color: (_selectedIndex == 1)
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'Explora',
                                      style: TextStyle(
                                          color: (_selectedIndex == 1)
                                              ? Colors.white
                                              : Colors.grey),
                                    )
                                  ]),
                            ),
                          ),
                          onTap: () async {
                            if (flag == false) {
                              await userProvider.usuarioRegistrado(user.uid);
                              flag = true;
                            }
                            _selectedIndex = 1;
                            setState(() {
                              _navigationController.value = 1;
                              filtroProvider.reseteProvider();
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: (() async {
                            if (flag == false) {
                              await userProvider.usuarioRegistrado(user.uid);
                              flag = true;
                            }
                            _selectedIndex = 2;
                            setState(() {
                              _navigationController.value = 2;
                              filtroProvider.reseteProvider();
                            });
                          }),
                          child: SizedBox(
                            width: 70,
                            height: double.infinity,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      (Icons.person),
                                      color: (_selectedIndex == 2)
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'Perfil',
                                      style: TextStyle(
                                          color: (_selectedIndex == 2)
                                              ? Colors.white
                                              : Colors.grey),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: bodyContainer(),
              ),
            ],
          );
        }
      },
    ));
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
        _selectedIndex = selectedPos ?? 0;
        setState(() {
          filtroProvider.reseteProvider();
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
