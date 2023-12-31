import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/bloc.dart';
import 'package:my_app/home.dart';
import 'package:my_app/onDay.dart';
import 'package:my_app/reponsitories/item_reponsitory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ItemRepository(),
      child: BlocProvider(
        create: (context) {
          return ItemBloc(RepositoryProvider.of(context))..add(LoadItem());
        },
        child: MaterialApp(
          theme: ThemeData(primaryColor: Color.fromARGB(255, 206, 143, 6)),
          home: BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              if (state is ItemLoaded) return HomePage();
              if (state is DetailLoaded) return OnDay();
              if (state is ItemError)
                return Container(
                  child: Text(state.mess!),
                );
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
