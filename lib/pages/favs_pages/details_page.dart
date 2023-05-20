import 'package:flutter/material.dart';
import 'package:plan_app/models/plan_model.dart';
import 'package:plan_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DetailFavPage extends StatelessWidget {
  final PlanModel planmodel;

  DetailFavPage({super.key, required this.planmodel});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/images/penia_martos.jpg'),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            top: 45 + MediaQuery.of(context).padding.top,
            left: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: Offset(0, -4),
                        blurRadius: 8)
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              planmodel.nombre,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]),
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.favorite_border_sharp,
                              size: 30,
                              color: (userProvider.estaEnFav(planmodel.id)
                                  ? Colors.red
                                  : null),
                            ),
                            onTap: () {
                              userProvider.agregaViajeFav(planmodel.id);
                              userProvider.estaEnFav(planmodel.id);
                              print('actualizando');
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.5,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${planmodel.cAutonoma}, ${planmodel.provincia}",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 30,
                          right: 30,
                        ),
                        child: Text(
                            style: TextStyle(color: Colors.grey[700]),
                            "${planmodel.desc}")),
                    SizedBox(height: 50),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () => print('Añadiendo plan a realizados'),
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                'Realizar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
