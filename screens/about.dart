import 'package:flutter/material.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Rental Home App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'आपका अपना,\n किराये का घर',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://picsum.photos/200/300'), // अपनी इमेज यूआरएल डालें
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(' Office Address:'),
                    Text(' 52, Rani Durgawati Ward No 9,'),
                    Text(' Anadi Road,Nainpur'),
                    Text(' Mandla,M.P. India'),
                    Text(' Phone: 123-456-7890'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
