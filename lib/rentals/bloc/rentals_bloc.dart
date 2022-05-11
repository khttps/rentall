import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/rent_period.dart';
import '../../data/repository/rental_repository.dart';
import '../../data/model/governorate.dart';
import '../../data/model/property_type.dart';
import '../../data/model/rental.dart';

part 'rentals_event.dart';
part 'rentals_state.dart';

class RentalsBloc extends Bloc<RentalsEvent, RentalsState> {
  final RentalRepository _repository;
  final SharedPreferences _preferences;
  RentalsBloc({
    required RentalRepository repository,
    required SharedPreferences preferences,
  })  : _repository = repository,
        _preferences = preferences,
        super(const RentalsState()) {
    on<GetRentals>(_onGetRentals);
    on<SetRegionFilter>(_onSetRegionFilter);
    on<SetPropertyTypeFilter>(_onSetPropertyTypeFilter);
    on<SetPriceFilter>(_onSetPriceFilter);
    on<SetPeriodFilter>(_onSetPeriodFilter);
  }

  FutureOr<void> _onGetRentals(GetRentals event, emit) async {
    final governorate = _preferences.getInt('governorate');

    emit(state.copyWith(
      status: RentalsLoadStatus.loading,
      governorate: Governorate.values[governorate ?? 0],
    ));

    try {
      final rentals = await _repository.getRentals(state.filters);
      emit(state.copyWith(
        status: RentalsLoadStatus.success,
        rentals: rentals,
      ));
    } on Exception catch (err) {
      rethrow;
      emit(state.copyWith(
        status: RentalsLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onSetRegionFilter(SetRegionFilter event, emit) async {
    final governorate = event.governorate;
    emit(state.copyWith(
      status: RentalsLoadStatus.reloading,
      governorate: governorate,
    ));

    if (governorate.value != null) {
      _preferences.setInt('governorate', governorate.index);
    } else {
      _preferences.remove('governorate');
    }

    try {
      final rentals = await _repository.getRentals(state.filters);
      emit(state.copyWith(
        status: RentalsLoadStatus.success,
        rentals: rentals,
      ));
    } on Exception catch (err) {
      rethrow;
      emit(state.copyWith(
        status: RentalsLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onSetPropertyTypeFilter(
    SetPropertyTypeFilter event,
    emit,
  ) async {
    emit(state.copyWith(
      status: RentalsLoadStatus.reloading,
      type: event.type,
    ));
    try {
      final rentals = await _repository.getRentals(state.filters);
      emit(state.copyWith(
        status: RentalsLoadStatus.success,
        rentals: rentals,
      ));
    } on Exception catch (err) {
      rethrow;
      emit(state.copyWith(
        status: RentalsLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onSetPriceFilter(SetPriceFilter event, emit) async {
    emit(state.copyWith(
      status: RentalsLoadStatus.reloading,
      priceFrom: event.priceFrom,
      priceTo: event.priceTo,
    ));
    try {
      final rentals = await _repository.getRentals(state.filters);
      emit(state.copyWith(
        status: RentalsLoadStatus.success,
        rentals: rentals,
      ));
    } on Exception catch (err) {
      rethrow;
      emit(state.copyWith(
        status: RentalsLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onSetPeriodFilter(SetPeriodFilter event, emit) async {
    emit(state.copyWith(
      status: RentalsLoadStatus.reloading,
      period: event.period,
    ));
    try {
      final rentals = await _repository.getRentals(state.filters);
      emit(state.copyWith(
        status: RentalsLoadStatus.success,
        rentals: rentals,
      ));
    } on Exception catch (err) {
      rethrow;
      emit(state.copyWith(
        status: RentalsLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }
}
