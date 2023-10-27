import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/bloc.dart';
import 'package:my_app/model/item.dart';

mixin FormDialog {
  Future<Item?> openAddItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final dayController = TextEditingController();
    final itemController = TextEditingController();
    final payController = TextEditingController();
    ItemState state = context.read<ItemBloc>().state;

    if (state is DetailLoaded) nameController.text = state.items[0].name;
    dayController.text = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: TextField(
            // controller: textInputTitleController,
            decoration:
                const InputDecoration(fillColor: Color(0XFF322a1d), hintText: 'Tạo mục mới', border: InputBorder.none)),
        content: Form(
            child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nhập tên",
              ),
            ),
            TextFormField(
              controller: dayController,
              decoration: InputDecoration(
                labelText: "Ngày",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: itemController,
                  decoration: InputDecoration(
                    labelText: "Mục",
                  ),
                ),
                TextFormField(
                  controller: payController,
                  decoration: InputDecoration(
                    labelText: "Tiền",
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
