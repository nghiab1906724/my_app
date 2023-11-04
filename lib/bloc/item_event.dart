part of 'bloc.dart';

class ItemEvent extends Equatable {
  const ItemEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadItem extends ItemEvent {}

class LoadDetail extends ItemEvent {
  final List<Item> items;
  const LoadDetail({required this.items});
}

class AddItem extends ItemEvent {
  final Item item;
  AddItem({required this.item});
}

class RemoveItem extends ItemEvent {
  final List<Item> items;
  const RemoveItem({required this.items});
}
