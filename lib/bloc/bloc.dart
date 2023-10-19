import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/reponsitories/data_reponsitory.dart';

part 'event.dart';
part 'state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataRepository dataRepo;
  String? key;
  DataBloc({required this.dataRepo}):super(DataState(data: dataRepo.getData())) {
    on<ReLoad>((event, emit) => emit(DataState(data: dataRepo.getData())),);
  }
}
