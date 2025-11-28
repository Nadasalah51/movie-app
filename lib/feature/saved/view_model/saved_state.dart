part of 'saved_cubit.dart';

@immutable
abstract class SavedState {}

class SavedInitial extends SavedState {}


class SavedLoading extends SavedState{}

class SavedSuccess extends SavedState{}

class SavedErrorstate extends SavedLoading{
   final String message;
  SavedErrorstate({required this.message});
}