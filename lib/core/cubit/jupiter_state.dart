part of 'jupiter_cubit.dart';

class JupiterState {}

class JupiterInitial extends JupiterState {}

class ImageChangedState extends JupiterState {
  String? imageUrl;
  ImageChangedState(this.imageUrl);
}
