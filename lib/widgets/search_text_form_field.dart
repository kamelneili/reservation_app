import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypfeapp/blocs/search/search_bloc.dart';
import 'package:mypfeapp/blocs/search/search_event.dart';
import 'package:mypfeapp/screens/search/screens/search_screen.dart';

class SearchTextFormField extends StatefulWidget {
  const SearchTextFormField({
    super.key,
  });

  @override
  State<SearchTextFormField> createState() =>
      _GrocerySearchTextFormFieldState();
}

class _GrocerySearchTextFormFieldState extends State<SearchTextFormField> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    print(query);
    context.read<SearchBloc>().add(SearchProductEvent(query: query));
  }

  TextEditingController keyController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    keyController.dispose();
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
      ),
      child: TextFormField(
        onFieldSubmitted: navigateToSearchScreen,
        controller: keyController,

        // context
        //     .read<SearchBloc>()
        //     .add(SearchProductEvent(query: 'margoum')),

        decoration: InputDecoration(
          hintText: '  recherche par nombre de personnes ',
          hintStyle: textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            color: Colors.orange.shade300,
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName,
                  arguments: keyController.text);
              print(keyController.text);
              context
                  .read<SearchBloc>()
                  .add(SearchProductEvent(query: keyController.text));
            },
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: colorScheme.onPrimaryContainer.withAlpha(100),
        ),
      ),
    );
  }
}
