part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int destination;
  final DeviceWide deviceWide;

  const HomeState({
    required this.destination,
    required this.deviceWide,
  });

  @override
  List<Object?> get props => [destination, deviceWide];

  HomeState copyWith({
    int? destination,
    DeviceWide? deviceWide,
  }) {
    return HomeState(
      destination: destination ?? this.destination,
      deviceWide: deviceWide ?? this.deviceWide,
    );
  }
}

enum DeviceWide {
  small,
  medium,
  large;

  bool get isSmall => this == DeviceWide.small;
  bool get isMedium => this == DeviceWide.medium;
  bool get isLarge => this == DeviceWide.large;
  bool get isWideScreen => this == DeviceWide.medium || this == DeviceWide.large;
}