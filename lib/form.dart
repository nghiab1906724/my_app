import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/bloc.dart';
import 'package:my_app/model/item.dart';

class Form extends StatefulWidget {
  final Map<String, dynamic>? valueForm;
  const Form({super.key, required this.state});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final _nameController = TextEditingController();
  final _dayController = TextEditingController();
  final _itemController = TextEditingController();
  final _payController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dayController.dispose();
    _itemController.dispose();
    _payController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        openAddItemDialog(context);
      },
    );
  }

  Future<Item?> openAddItemDialog(BuildContext context) {
    if (widget.state is DetailLoaded) _nameController.text = widget.state.items[0].name;
    _dayController.text = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Tạo mục mới"),
        content: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nhập tên",
              ),
            ),
            TextFormField(
              controller: _dayController,
              decoration: InputDecoration(
                labelText: "Ngày",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: _itemController,
                  decoration: InputDecoration(
                    labelText: "Mục",
                  ),
                ),
                TextFormField(
                  controller: _payController,
                  decoration: InputDecoration(
                    labelText: "Tiền",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
