import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../screens/home/model/task_model.dart';
import '../../services/firestore_service.dart';

part 'get_task_list_state.dart';

class GetTaskListCubit extends Cubit<GetTaskListState> {
  GetTaskListCubit() : super(GetTaskListInitial());
  final FirestoreService _firestoreService = FirestoreService();
  Future<void> getTaskList()async{
  try{
    emit(GetTaskListLoading());
    _firestoreService.getTasks().listen((List<Task> onData){
      emit(GetTaskListLoaded(list: onData));
    });
  }catch(e){
    emit(GetTaskListFailed());
  }
  }
}
