import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/media.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: ListView(
        children: [
          SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Todos tus cultivos",
                            style: AppStyles.headLineStyle3),
                        const SizedBox(height: 5,),
                        Text("Historial",
                            style: AppStyles.headLineStyle1)
                      ],
                    ),

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: AssetImage(AppMedia.logo)
                          )
                      ),
                    )
                  ],
                ),
              ],
            )),
          Container(
            child: Column(
              children: [
                const SizedBox(height:25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal:12, vertical:12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF4F6FD)
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search, color:Color(0xFFBFC205)),
                      Text("Buscar")
                    ],
                  ),
                ),

                Container(
                  child: const Text("Resultados"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
