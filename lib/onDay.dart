import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/bloc.dart';
import 'package:my_app/form_dialog.dart';
import 'package:my_app/model/item.dart';

class OnDay extends StatelessWidget with FormDialog {
  const OnDay({super.key});

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
    return BlocConsumer<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is DetailLoaded)
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 255, 147, 7),
                  title: Text(state.items[0].name),
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
                floatingActionButton: BlocListener<ItemBloc, ItemState>(
                  listener: (context, state) {
                    if (state is DetailLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Task Updated!'),
                      ));
                    }
                  },
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xFFf8bd47),
                    foregroundColor: const Color(0xFF322a1d),
                    onPressed: () async {
                      Item? item = await openAddItemDialog(context);
                      // if (task != null) {
                      //   context.read<TasksBloc>().add(
                      //         AddTask(task: task),
                      //       );
                      // }
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ),
              ));
        else
          return CircularProgressIndicator();
      },
      listener: (context, state) {},
    );
  }

  Widget _buildDebtView(DetailLoaded state) {
    var dataList = state.items.where((element) => element.debt).toList();
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.amber[400],
          child: _buildRow(context, dataList[index]),
        );
      },
    );
  }

  Widget _buildNotDebtView(DetailLoaded state) {
    var dataList = state.items.where((element) => !element.debt).toList();
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.amber[400],
          child: _buildRow(context, dataList[index]),
        );
      },
    );
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
          Text(item.money.toString()),
        ],
      ),
      onTap: () {
        // // context.read<DataBloc>().key = m['name'];
        // Navigator.of(context).pushNamed("/onday");
        // context.read<ItemBloc>().add(LoadDetail(items: state.items.where((element) => element.name==m['name']).toList()));
      },
    );
  }

  // Future<Item?> _openDialog(BuildContext context) {
  //   final nameController=TextEditingController();
  //   final dayController=TextEditingController();
  //   ItemState state=context.read<ItemBloc>().state;

  //   if(state is DetailLoaded) nameController.text=state.items[0].name;
  //   dayController.text=DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();

  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: Colors.white,
  //       title: TextField(
  //           // controller: textInputTitleController,
  //           decoration: const InputDecoration(
  //               fillColor: Color(0XFF322a1d),
  //               hintText: 'Tạo mục mới',
  //               border: InputBorder.none)),
  //       content: Form(child: Column(
  //         children: [
  //           TextFormField(
  //             controller: nameController,
  //             decoration: InputDecoration(
  //               labelText: "Nhập tên",
  //             ),
  //           ),
  //           TextFormField(
  //             controller: dayController,
  //             decoration: InputDecoration(
  //               labelText: "Ngày",
  //             ),
              
  //           ),
  //         ],
  //       )),
  //     ),
  //   );
  // }
}
