part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int destination;

  final DeviceWide deviceWide;

  const HomeState({required this.destination, required this.deviceWide});

  @override
  List<Object?> get props => [destination];

  HomeState copyWith({int? destination, DeviceWide? deviceWide}) {
    return HomeState(
      destination: destination ?? this.destination,
      deviceWide: deviceWide ?? this.deviceWide,
    );
  }
}

enum DeviceWide { small, medium, large }
