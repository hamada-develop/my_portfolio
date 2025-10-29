import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';



class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(destination: 0, deviceWide: DeviceWide.small));

  void changeDestination(int index) {
    emit(state.copyWith(destination: index));
  }

  void updateDeviceWidth(double width) {
    print('updateDeviceWidth: $width');
    DeviceWide deviceWide;

    if (width < 600) {
      deviceWide = DeviceWide.small;
    } else if (width < 1000) {
      print('medium ');
      deviceWide = DeviceWide.medium;
    } else {
      deviceWide = DeviceWide.large;
    }

    if (deviceWide != state.deviceWide) {
      emit(state.copyWith(deviceWide: deviceWide));
    }
  }
}