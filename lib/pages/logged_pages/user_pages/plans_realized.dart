import 'package:flutter/material.dart';
import 'package:plan_app/pages/logged_pages/user_pages/plans_realized_details.dart';
import 'package:plan_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class PlansRealizedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final List<Widget> fancyCards = <Widget>[
      Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(30)),
        child: Center(
            child: Text(
          (userProvider.planesRealizados.isEmpty)
              ? 'No se han encontrado planes :('
              : 'Se han encontrado ${userProvider.planesRealizados.length} plan/es',
          style: TextStyle(color: Colors.white),
        )),
      )
    ];
    userProvider.planesRealizados.asMap().forEach((index, plan) {
      fancyCards.add(MyCard(
        image: 'lib/images/penia_martos.jpg',
        boxDecoration: BoxDecoration(),
        color: Colors.grey,
        posicion: index,
      ));
    });
    return Scaffold(
      body: Center(
          child: StackedCardCarousel(
        initialOffset: 120,
        items: fancyCards,
      )),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.boxDecoration,
    required this.color,
    required this.image,
    required this.posicion,
  }) : super(key: key);

  final BoxDecoration boxDecoration;
  final Color color;
  final String image;
  final int posicion;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Stack(children: [
      Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Stack(children: [
          Positioned(
            top: 45 + MediaQuery.of(context).padding.top,
            left: 30,
            child: ClipOval(
              child: Container(
                height: 42,
                width: 41,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      offset: Offset(0, 4),
                      blurRadius: 8)
                ]),
                child: Center(child: Icon(Icons.arrow_back)),
              ),
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                image: DecorationImage(
                    image: AssetImage('lib/images/penia_martos.jpg'),
                    fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 175,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(25)),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  userProvider.planesRealizados[posicion].nombre,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${userProvider.planesRealizados[posicion].cAutonoma}, ${userProvider.planesRealizados[posicion].provincia}',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${userProvider.planesRealizados[posicion].tipoPlan}',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlanRealizedDetailPage(
                                planmodel:
                                    userProvider.planesRealizados[posicion],
                              ))),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    width: 150,
                    height: 40,
                    child: const Center(
                        child: Text(
                      'Ver detalles',
                    )),
                  ),
                )
              ]),
            ),
          )
        ]),
      ),
    ]);
  }
}
