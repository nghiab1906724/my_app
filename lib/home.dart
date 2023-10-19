import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/item/bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.state});
  final DataState state;



  List<Map<String, dynamic>> getDataView(){
    List<Map<String, dynamic>> dataList=[];

    state.data.forEach((key, value) {
      Map<String, dynamic> m = {};
      m['name'] = key;
      m['0'] = 0;
      m['1'] = 0;
      value.forEach((key, value) {
        value["0"].forEach((key, value) {
          m['0'] += value;
          print(m['0']);
        });
        value["1"].forEach((key, value) {
          m['1'] += value;
        });
      });
      dataList.add(m);
    });
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataList=getDataView();
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang Chủ"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index < dataList.length) return Container(
            child: buildRow(context, dataList[index]),
            color: Colors.greenAccent,
          );
        },
        
      ),
    );
  }

  Widget buildRow(BuildContext context, Map<String, dynamic> m) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${m['name']}:", style: TextStyle(fontWeight: FontWeight.bold),),
          Text("${m['name']} thiếu: ${m['0']}"),
          Text("Thiếu ${m['name']}: ${m['1']}"),
          Container(
            child: Text((m['0']-m['1']).toString(), style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      onTap: () {context.read<DataBloc>().key=m['name'];
        Navigator.of(context).pushNamed("/onday");
      },
    );
  }
}
