import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/item/bloc.dart';
import 'package:my_app/main.dart';

class OnDay extends StatelessWidget {
  final DataState state;
  const OnDay({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    String name = context.read<DataBloc>().key ?? "";    
    if (name == "") return MyApp();
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if(index<1)return buildRow(state.data[name]);
        },
      ),
    );
  }

  Widget buildRow(Map m) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
           m[1],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
