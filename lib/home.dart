import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/bloc.dart';
import 'package:my_app/form.dart';
import 'package:my_app/model/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> getData(List<Item> items) {
    List<Map<String, dynamic>> l = [];
    Map<String, int> check = {};
    int k = 0;
    check[items[0].name] = k++;
    l.add({"name": items[0].name, "true": 0, "false": 0});
    items.forEach((element) {
      if (check.containsKey(element.name)) {
        element.debt
            ? l[check[element.name]!]['true'] += element.money
            : l[check[element.name]!]['false'] += element.money;
      } else {
        check[element.name] = k;
        l.add({"name": element.name, "true": 0, "false": 0});
        if (element.debt) {
          l[k]['true'] = element.money;
          l[k]['false'] = 0;
        } else {
          l[k]['false'] = element.money;
          l[k]['true'] = 0;
        }
        k++;
      }
    });
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 147, 7),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Trang Chủ"),
            Switch(
              // This bool value toggles the switch.
              value: ItemState.isRemove,
              overlayColor: const MaterialStatePropertyAll<Color>(Colors.red),
              trackColor: ItemState.isRemove
                  ? const MaterialStatePropertyAll<Color>(Colors.yellow)
                  : const MaterialStatePropertyAll<Color>(Colors.white),
              thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
              activeColor: Colors.black,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  ItemState.isRemove = value;
                });
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoaded) {
            return _buildView(state);
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFf8bd47),
        foregroundColor: const Color(0xFF322a1d),
        onPressed: () async {
          await _openDialog(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildView(ItemLoaded state) {
    if (state.items.isEmpty) return Container();
    List dataList = getData(state.items);
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.orange, width: 5.0),
            ),
            color: Colors.amber[400],
          ),
          child: _buildRow(context, dataList[index], state),
        );
      },
    );
  }

  Widget _buildRow(
      BuildContext context, Map<String, dynamic> m, ItemLoaded state) {
    final row =
        state.items.where((element) => element.name == m['name']).toList();
    return ListTile(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${m['name']}:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                child: Text("${(m['true'] - m['false']).toString()}k",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${m['name']} nợ: ${m['true']}k"),
              Text("Nợ ${m['name']}: ${m['false']}k"),
            ],
          ),
        ],
      ),
      onTap: () {
        context.read<ItemBloc>().add(LoadDetail(items: row));
      },
      leading: ItemState.isRemove
          ? IconButton(
              onPressed: () {
                context.read<ItemBloc>().add(RemoveItem(items: row));
              },
              icon: Icon(
                Icons.remove_circle,
                color: Color.fromARGB(255, 244, 124, 54),
              ),
            )
          : null,
    );
  }

  Future<Item?> _openDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Container(
              child: AlertDialog(
                backgroundColor: Colors.white,
                title: Center(
                  child:
                      Text("Tạo mục mới", style: TextStyle(color: Colors.blue)),
                ),
                content: AddForm(
                  valueForm: {
                    'date':
                        DateFormat('EEEE - dd/MM/yyyy').format(DateTime.now())
                  },
                  onChanged: onChanged,
                ),
              ),
            ));
  }

  void onChanged(BuildContext context, Map<String, dynamic> jsItem) {
    context.read<ItemBloc>().add(AddItem(item: Item.fromJson(jsItem)));
  }
}
