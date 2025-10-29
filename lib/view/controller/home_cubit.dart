import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(const HomeState(
    destination: 0,
    deviceWide: DeviceWide.small,
  ));

  /// Changes the selected destination index
  void changeDestination(int index) {
    if (state.destination != index) {
      emit(state.copyWith(destination: index));
    }
  }

  /// Updates device width category with threshold-based logic
  void updateDeviceWidth(double width) {
    final DeviceWide newDeviceWide = _calculateDeviceWide(width);

    // Only emit if the device width category actually changed
    if (newDeviceWide != state.deviceWide) {
      emit(state.copyWith(deviceWide: newDeviceWide));
    }
  }

  /// Calculates device width category based on breakpoints
  DeviceWide _calculateDeviceWide(double width) {
    if (width < 600) {
      return DeviceWide.small;
    } else if (width < 1000) {
      return DeviceWide.medium;
    } else {
      return DeviceWide.large;
    }
  }
}