part of 'bloc.dart';

class ItemState extends Equatable{
  const ItemState();
@override
  // TODO: implement props)
  List<Object?> get props => [];
}

class ItemLoaded extends ItemState{
  final List<Item> items;
  const ItemLoaded({this.items=const <Item>[]});
}

class ItemLoading extends ItemState{}

class ItemError extends ItemState{
  final String? mess;
  const ItemError(this.mess);
}

class DetailLoaded extends ItemState{
  final List<Item> items;
  const DetailLoaded({this.items=const []});
}