import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypfeapp/home/blocs/actualite_bloc.dart';
import 'package:mypfeapp/home/blocs/actualite_event.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/widgets/custom_buttom.dart';
import 'package:readmore/readmore.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController imageController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController nbrpersController = TextEditingController();

  final TextEditingController dispoController = TextEditingController();

  final TextEditingController catController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final TextEditingController nameController = TextEditingController();

    final TextEditingController imageController = TextEditingController();

    final TextEditingController descriptionController = TextEditingController();

    final TextEditingController priceController = TextEditingController();

    final TextEditingController nbrpersController = TextEditingController();

    final TextEditingController dispoController = TextEditingController();

    final TextEditingController catController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('Ajouter une Actualité'),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionController,
                            autofocus: true,
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 8,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid description';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'description',
                              //filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid title';
                              }
                              return null;
                            },
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Titre',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: catController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid category';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Category',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: priceController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid price';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Price',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid nombre';
                              }
                              return null;
                            },
                            controller: nbrpersController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre pers',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid imageUrl';
                              }
                              return null;
                            },
                            controller: imageController,
                            decoration: const InputDecoration(
                              labelText: 'ImageUrl',
                            ),
                          ),
                        ])),

                //
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: CustomButton(
                      title: "Sauvgarder Actualité",
                      onTap: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            context.read<ActualiteBloc>().add(AddActualite(
                                Actualite(
                                    name: nameController.text,
                                    description: descriptionController.text,
                                    image: imageController.text,
                                    dispo: true,
                                    category: catController.text,
                                    price: priceController.text,
                                    nbprs: nbrpersController.text)));
                            const snackBar = SnackBar(
                                content: Text('Actualité ajoutée !!!',
                                    style: TextStyle(color: Colors.green)));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            //    Navigator.of(context).pushNamed(
                            //   '/loginScreen',
                            // );
                          } else {
                            setState(() {
                              initState();
                            });
                          }
                        });
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
