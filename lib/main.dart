import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/item/bloc.dart';
import 'package:my_app/home.dart';
import 'package:my_app/onDay.dart';
import 'package:my_app/reponsitories/data_reponsitory.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => DataRepository(),
        child: BlocProvider(
                create:(context) {
                  return DataBloc(dataRepo: RepositoryProvider.of(context));
                },
                child: MaterialApp(
                  routes: {
                    '/': (context) => BlocBuilder<DataBloc, DataState>(
                          builder: (context, state) => HomePage(
                            state: state,
                          ),
                        ),
                    '/onday': (context) => BlocBuilder<DataBloc, DataState>(
                      builder: (context, state) => OnDay(state: state,),
                    ),
                  },
                  initialRoute: '/',
                  title: "MyApp",
                ),
              ),
        );
  }
}
