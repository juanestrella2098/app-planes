import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../../../providers/filtro_providers.dart';
import 'details_plans_searched.dart';

class PlanSearchedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filtroProvider = Provider.of<FiltroProviders>(context);
    final List<Widget> fancyCards = <Widget>[
      Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (filtroProvider.planesAux.isEmpty)
                  ? 'No se han encontrado planes :('
                  : 'Se han encontrado ${filtroProvider.planesAux.length} plan/es, Desliza para arriba o para abajo para ver los planes',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    ];
    filtroProvider.planesAux.asMap().forEach((index, plan) {
      fancyCards.add(MyCard(
        image: filtroProvider.planesAux[index].foto,
        boxDecoration: BoxDecoration(),
        color: Colors.grey,
        posicion: index,
      ));
    });
    return Scaffold(
      body: Center(
          child: StackedCardCarousel(
        type: StackedCardCarouselType.fadeOutStack,
        spaceBetweenItems: 800,
        initialOffset: 200,
        items: fancyCards,
        pageController: filtroProvider.pageControllerFilter,
        onPageChanged: (pageIndex) {},
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 10),
        child: FloatingActionButton(
            backgroundColor: Colors.grey[700],
            onPressed: (() {
              Navigator.pop(context);
            }),
            elevation: 0,
            child: const Icon(Icons.arrow_back)),
      ),
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
    final filtroProvider = Provider.of<FiltroProviders>(context);

    return Stack(children: [
      Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Stack(children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        Image.network(filtroProvider.planesAux[posicion].foto)
                            .image)),
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
                  filtroProvider.planesAux[posicion].nombre,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${filtroProvider.planesAux[posicion].cAutonoma}, ${filtroProvider.planesAux[posicion].provincia}',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${filtroProvider.planesAux[posicion].tipoPlan}',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPlansSearchedPage(
                                planmodel: filtroProvider.planesAux[posicion],
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
