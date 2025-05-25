import 'package:flutter/material.dart';
import '../../../../widgets/custom_container.dart';

class AcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          boxHeight: 260,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Acerca de nosotros",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              Text(
                "Somos una empresa dedicada al bienestar y la salud física, ofreciendo clases y programas personalizados para todas las edades. Nuestro objetivo es mejorar la calidad de vida de nuestros clientes a través de la actividad física y el acompañamiento profesional.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        CustomContainer(
          boxHeight: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sede central",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              Text(
                "Av. Principal 1234, Col. Centro\nCiudad Saludable, CP 12345\nTel: (999) 123-4567",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        CustomContainer(
          boxHeight: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Contáctenos",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              Text(
                "Email: contacto@bienestar.com\nWhatsApp: +52 999 888 7777\nHorario de atención: Lun-Vie 8:00-18:00",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}