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

  _onLoadDetail(LoadDetail event, Emitter<ItemState> emit){
    emit(DetailLoaded(items: event.items));
  }
}
