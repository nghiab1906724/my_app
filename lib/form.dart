import 'package:flutter/material.dart';
import 'package:my_app/model/item.dart';

class AddForm extends StatefulWidget {
  final Map<String, dynamic>? valueForm;
  const AddForm(
      {super.key, this.valueForm = const {}, required this.onChanged});
  final Function(BuildContext context, Map<String, dynamic>) onChanged;

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _nameController = TextEditingController();
  final _dayController = TextEditingController();
  final _itemController = TextEditingController();
  final _payController = TextEditingController();
  bool _isChecked = false;

  @override
  void initState() {
    _nameController.text = widget.valueForm?['name'] ?? '';
    _dayController.text = widget.valueForm?['date'] ?? '';
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
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _itemController,
                  decoration: InputDecoration(
                    labelText: "Mục",
                  ),
                ),
              ),
              Text(" "),
              Expanded(
                child: TextFormField(
                  controller: _payController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Tiền(k)",
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Tôi mượn:"),
              Checkbox(
                value: this._isChecked,
                onChanged: (value) {
                  setState(() {
                    this._isChecked = value!;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Hủy"),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onChanged(
                    context,
                    {
                      "id": Item.index,
                      "name": _nameController.text,
                      "date": _dayController.text,
                      "debt": !this._isChecked,
                      "item": _itemController.text,
                      "money": int.parse(_payController.text),
                    },
                  );
                },
                child: Text("Lưu"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
