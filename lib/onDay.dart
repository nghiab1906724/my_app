import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/bloc.dart';
import 'package:my_app/form.dart';
import 'package:my_app/model/item.dart';

class OnDay extends StatefulWidget {
  const OnDay({super.key});

  @override
  State<OnDay> createState() => _OnDayState();
}

class _OnDayState extends State<OnDay> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is DetailLoaded)
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        context.read<ItemBloc>().add(LoadItem());
                      },
                      icon: Icon(Icons.arrow_back)),
                  backgroundColor: Color.fromARGB(255, 255, 147, 7),
                  title: Text(state.items[0].name),
                  actions: [
                    Switch(
                      // This bool value toggles the switch.
                      value: ItemState.isRemove,
                      overlayColor:
                          const MaterialStatePropertyAll<Color>(Colors.red),
                      trackColor: ItemState.isRemove
                          ? const MaterialStatePropertyAll<Color>(Colors.yellow)
                          : const MaterialStatePropertyAll<Color>(Colors.white),
                      thumbColor:
                          const MaterialStatePropertyAll<Color>(Colors.black),
                      activeColor: Colors.black,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          ItemState.isRemove = value;
                        });
                      },
                    ),
                  ],
                  bottom: TabBar(tabs: [
                    Tab(
                      text: "${state.items[0].name} nợ",
                    ),
                    Tab(
                      text: "Nợ ${state.items[0].name}",
                    ),
                  ]),
                ),
                body: TabBarView(children: [
                  _buildDebtView(state),
                  _buildNotDebtView(state),
                ]),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: const Color(0xFFf8bd47),
                  foregroundColor: const Color(0xFF322a1d),
                  onPressed: () async {
                    await _openDialog(context, state.items[0].name);
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ));
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
      listener: (context, state) {},
    );
  }

  Widget _buildDebtView(DetailLoaded state) {
    if (state.items[0].id != -1) {
      var dataList = state.items.where((element) => element.debt).toList();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildRow(context, dataList[index]),
                Text(dataList[index].date),
              ],
            ),
          );
        },
      );
    } else
      return Container();
  }

  Widget _buildNotDebtView(DetailLoaded state) {
    if (state.items[0].id != -1) {
      var dataList = state.items.where((element) => !element.debt).toList();
      return ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return Container(
              color: Colors.amber[400],
              child: Column(
                children: [
                  _buildRow(context, dataList[index]),
                  Text(dataList[index].date),
                ],
              ));
        },
      );
    } else
      return Container();
  }

  Widget _buildRow(BuildContext context, Item item) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.item,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("${item.money.toString()}k"),
        ],
      ),
      onTap: () {},
      leading: ItemState.isRemove
          ? IconButton(
              onPressed: () {
                context.read<ItemBloc>().add(RemoveItem(items: [item]));
              },
              icon: Icon(
                Icons.remove_circle,
                color: Color.fromARGB(255, 244, 124, 54),
              ),
            )
          : null,
    );
  }

  Future<Item?> _openDialog(BuildContext context, String name) {
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
                    'name': name,
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
