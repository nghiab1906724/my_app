import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/bloc.dart';
import 'package:my_app/model/item.dart';
import 'package:my_app/reponsitories/item_reponsitory.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Map<String, dynamic>> getData(List<Item> items) {
    Map<String, dynamic> m = {"name": items[0].name, "true": 0, "false": 0};
    List<Map<String, dynamic>> l = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i].name == m['name']) {
        if (items[i].debt)
          m['true'] += items[i].money;
        else
          m['false'] += items[i].money;
      } else {
        l.add(m);
        m = {"name": items[i].name, "true": 0, "false": 0};
        i--;
      }
    }
    l.add(m);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 147, 7),
        title: Text("Trang Chủ"),
      ),
      body: BlocConsumer<ItemBloc, ItemState>(
        // bloc: context.read<ItemBloc>(),
        buildWhen: (previous, current) {
          return current != DetailLoaded();
        },
        builder: (context, state) {
          if (state is ItemLoading) return CircularProgressIndicator();
          if (state is ItemLoaded && state.items.isNotEmpty) {
            return _buildView(state);
          } else
            return CircularProgressIndicator();
        },
        listener: (context, state) async {
          if (state is DetailLoaded) {
            await Navigator.of(context).pushNamed("/onday");
            context.read<ItemBloc>().add(LoadItem());
          }
        },
      ),
    );
  }

  Widget _buildView(ItemLoaded state) {
    List dataList = getData(state.items);
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.amber[400],
          child: _buildRow(context, dataList[index], state),
        );
      },
    );
  }

  Widget _buildRow(
      BuildContext context, Map<String, dynamic> m, ItemLoaded state) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${m['name']}:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("${m['name']} nợ: ${m['true']}"),
          Text("Nợ ${m['name']}: ${m['false']}"),
          Container(
            child: Text((m['true'] - m['false']).toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      onTap: () {
        // // context.read<DataBloc>().key = m['name'];
        // Navigator.of(context).pushNamed("/onday");
        context.read<ItemBloc>().add(LoadDetail(
            items: state.items
                .where((element) => element.name == m['name'])
                .toList()));
      },
    );
  }
}
