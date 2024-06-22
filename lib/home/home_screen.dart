// ignore: unused_import
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypfeapp/home/blocs/actualite_bloc.dart';
import 'package:mypfeapp/home/blocs/actualite_state.dart';
import 'package:mypfeapp/screens/home/top_categories.dart';
import 'package:mypfeapp/widgets/actualite_card.dart';
import 'package:mypfeapp/widgets/custom_navbar.dart';
import 'package:mypfeapp/widgets/search_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //curvednavigation:
      bottomNavigationBar: const CustomNavBar(),

      //appbar:
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    height: 130,
                    width: 160,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/pp.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Ikama Place",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SearchTextFormField(),
              const SizedBox(height: 2),
              const TopCategories(),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Nos Actualités",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 79, 78, 78)),
              textAlign: TextAlign.center,
            ),
          ),

          //Gridview:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topCenter,
              // color: Colors.blue,
              width: double.infinity,
              height: 500,
              child: BlocBuilder<ActualiteBloc, ActualiteState>(
                  builder: (context, state) {
                if (state is ActualiteLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
                if (state is ActualiteLoaded) {
                  return GridView.builder(
                    itemCount: state.actualites.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActualiteCard(actualite: state.actualites[index]),
                    ),
                  );
                } else {
                  return const Text('Something went wrong.');
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
