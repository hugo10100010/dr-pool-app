import 'package:flutter/material.dart';
import '../../../../widgets/custom_container.dart';
import '../../../../widgets/image_container_inicio.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: Image.asset(
                  "assets/inicio_1.jpg",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Bienvenido a",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Smart Fit",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Entrena tu vida",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: (Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize! *
                              (4 / 7))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            spacing: 15,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 5, 3, 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10),
            gradient: RadialGradient(
              colors: [
                Color(0xFF75ff52),
                Color(0xFF00a06a),
              ],
              center: Alignment.center,
              radius: 4.2,
            ),
          ),
          child: Text(
            "Novedades",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            spacing: 15,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}