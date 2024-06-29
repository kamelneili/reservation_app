import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypfeapp/widgets/custom_buttom.dart';

import '../../blocs/cubits/cubits.dart';
import '../../repositories/services/storage_service.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SignupScreen(),
    );
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  StorageRepository storage = StorageRepository();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController adress = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();

  TextEditingController zip = TextEditingController();
  @override
  void initState() {
    TextEditingController email = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController country = TextEditingController();
    TextEditingController adress = TextEditingController();
    TextEditingController zip = TextEditingController();

    TextEditingController phone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      // bottomNavigationBar: CustomNavBar(screen: routeName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignupCubit>().userChanged(
                              state.user!.copyWith(email: value),
                            );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignupCubit>().userChanged(
                              state.user!.copyWith(fullName: value),
                            );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: country,
                      decoration: const InputDecoration(
                        labelText: 'country',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid specialité';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignupCubit>().userChanged(
                              state.user!.copyWith(country: value),
                            );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: city,
                      decoration: const InputDecoration(
                        labelText: 'vile',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid city';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignupCubit>().userChanged(
                              state.user!.copyWith(city: value),
                            );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: adress,
                      decoration: const InputDecoration(
                        labelText: 'Adresse',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid address';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignupCubit>().userChanged(
                              state.user!.copyWith(address: value),
                            );
                      },
                    ),
                    Row(
                      children: [
                        const Text(
                          "Genre",
                        ),
                        DropdownButton<String>(
                          items: <String>['Locataire', 'propriétaire']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            context.read<SignupCubit>().userChanged(
                                  state.user!.copyWith(genre: value),
                                );
                          },
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: zip,
                      decoration: const InputDecoration(
                        labelText: 'ZIP Code',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignupCubit>().userChanged(
                              state.user!.copyWith(zipCode: value),
                            );
                      },
                    ),
                    // _PasswordInput(),
                    TextFormField(
                      onChanged: (password) {
                        context.read<SignupCubit>().passwordChanged(password);
                      },
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    //

                    //
                    // IconButton(
                    //   onPressed: () async {
                    //     ImagePicker _picker = ImagePicker();
                    //     final XFile? _image = await _picker.pickImage(
                    //         source: ImageSource.gallery); //gallery
                    //     if (_image == null) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text('No image was selected')));
                    //     }
                    //     if (_image != null) {
                    //       print('uploading...');
                    //       await storage.uploadImage(_image);
                    //       var imageUrl = await storage.getDownloadUrl(_image.name);
                    //       context.read<SignupCubit>().userChanged(
                    //             state.user!.copyWith(imageUrl: imageUrl),
                    //           );
                    //     }
                    //   },
                    //   icon: Icon(Icons.add_circle, color: Colors.black),
                    // ),

                    //

                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child:
                          //  (state.user!.imageUrl == null)?
                          //
                          Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 50,
                            );

                            if (image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No image was selected.')));
                            }

                            if (image != null) {
                              print('Uploading ...');
                              await storage.uploadImage(image);
                              var imageUrl =
                                  await storage.getDownloadUrl(image.name);
                              print(imageUrl);
                              context.read<SignupCubit>().userChanged(
                                    state.user!.copyWith(imageUrl: imageUrl),
                                  );
                              //
                              // BlocProvider.of<AuthBloc>(context).add(
                              //   UpdateUserImages(image: _image),
                              // );
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    //

                    CustomButton(
                      title: "Signup",
                      onTap: () {
                        // context.read<AuthRepository>().signOut();
                        if (_formKey.currentState!.validate()) {
                          context.read<SignupCubit>().signUpWithCredentials();
                          Navigator.of(context).pushNamed(
                            '/loginScreen',
                          );
                        } else {
                          setState(() {
                            initState();
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput({
    super.key,
    required this.onChanged,
    required this.labelText,
  });

  final Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your phone';
            }
            return null;
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (password) {
        context.read<SignupCubit>().passwordChanged(password);
      },
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your phone';
        }
        return null;
      },
    );
  }
}
