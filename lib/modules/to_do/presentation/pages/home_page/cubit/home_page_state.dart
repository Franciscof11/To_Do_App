part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = _Initial;
  const factory HomePageState.loading() = _Loading;
  const factory HomePageState.data({required List<Task> tasks}) = _Data;
  const factory HomePageState.error({required String message}) = _Error;
}
