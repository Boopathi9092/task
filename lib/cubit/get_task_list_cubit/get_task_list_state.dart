part of 'get_task_list_cubit.dart';

sealed class GetTaskListState extends Equatable {
  const GetTaskListState();
}

final class GetTaskListInitial extends GetTaskListState {
  @override
  List<Object> get props => [];
}

final class GetTaskListLoading extends GetTaskListState {
  @override
  List<Object> get props => [];
}

final class GetTaskListLoaded extends GetTaskListState {
  const GetTaskListLoaded({required  this.list});
  final List<Task> list;
  @override
  List<Object> get props => [list];
}

final class GetTaskListFailed extends GetTaskListState {
  @override
  List<Object> get props => [];
}
