import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/model/item.dart';
import 'package:my_app/reponsitories/item_reponsitory.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository _itemRepo;
  ItemBloc(this._itemRepo) : super(ItemLoaded()) {
    on<LoadItem>(_onLoadItem);
    on<LoadDetail>(_onLoadDetail);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemove);
  }

  Future<void> _onLoadItem(LoadItem event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    try {
      final items = await _itemRepo.getItem();
      emit(ItemLoaded(items: items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }

  _onLoadDetail(LoadDetail event, Emitter<ItemState> emit) {
    emit(DetailLoaded(items: event.items));
  }

  _onAddItem(AddItem event, Emitter<ItemState> emit) async {
    ItemState preState = state;
    emit(ItemLoading());
    try {
      final items = await _itemRepo.saveItem(event.item);
      if (preState is DetailLoaded)
        emit(DetailLoaded(
            items: items
                .where((element) => element.name == event.item.name)
                .toList()));
      else
        emit(ItemLoaded(items: items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }

  _onRemove(RemoveItem event, Emitter<ItemState> emit) async {
    ItemState preState = state;
    emit(ItemLoading());
    try {
      final items = await _itemRepo.removeItem(event.items);
      if (preState is DetailLoaded) {
        final showItem = items
            .where((element) => element.name == event.items[0].name)
            .toList();
        if (showItem.isNotEmpty)
          emit(DetailLoaded(items: showItem));
        else
          emit(DetailLoaded(items: [
            Item(
                id: -1,
                name: event.items[0].name,
                date: '',
                debt: true,
                item: '')
          ]));
      } else
        emit(ItemLoaded(items: items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }
}
