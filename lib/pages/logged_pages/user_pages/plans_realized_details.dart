import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:plan_app/models/plan_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class PlanRealizedDetailPage extends StatelessWidget {
  final PlanModel planmodel;

  const PlanRealizedDetailPage({super.key, required this.planmodel});

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
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Como estuvo la experiencia'),
                                    content: RatingBar(
                                        glowColor: Colors.yellow[700],
                                        tapOnlyMode: true,
                                        initialRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        ratingWidget: RatingWidget(
                                            full: Icon(Icons.star,
                                                color: Colors.yellow[700]),
                                            half: Icon(
                                              Icons.star_half,
                                              color: Colors.yellow[700],
                                            ),
                                            empty: Icon(
                                              Icons.star_outline,
                                              color: Colors.yellow[700],
                                            )),
                                        onRatingUpdate: (value) {
                                          userProvider
                                              .actualizaRating(value.toInt());
                                        }),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            userProvider
                                                .actualizaRatingUserPlan(
                                                    planmodel.id,
                                                    userProvider.votacion);
                                          },
                                          child: Text('Votar')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancelar'))
                                    ],
                                  )),
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                'Votar',
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
