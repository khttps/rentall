import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/enums/enums.dart';
import '../../../data/repositories/rental_repository.dart';
import '../../../data/models/models.dart';
part 'rentals_event.dart';
part 'rentals_state.dart';

class RentalsBloc extends Bloc<RentalsEvent, RentalsState> {
  final RentalRepository _repository;

  RentalsBloc({
    required RentalRepository repository,
  })  : _repository = repository,
        super(RentalsState()) {
    on<GetRentals>(_onGetRentals);
    on<FilterRentals>(_onFilterRentals);
    on<ClearRegionFilter>(_onClearRegionFilter);
    on<ClearPropertyTypeFilter>(_onClearPropertyTypeFilter);
  }

  FutureOr<void> _onGetRentals(
    GetRentals event,
    Emitter<RentalsState> emit,
  ) =>
      emit.onEach<List<Rental>>(
        _repository.getRentals(),
        onData: (rentals) {
          emit(RentalsState(status: LoadStatus.loaded, rentals: rentals));
        },
        onError: (error, stacktrace) {
          emit(state.copyWith(
            status: LoadStatus.error,
            error: stacktrace.toString(),
          ));
        },
      );

  FutureOr<void> _onFilterRentals(
    FilterRentals event,
    Emitter<RentalsState> emit,
  ) =>
      emit.onEach<List<Rental>>(
        _repository.getRentals(
          governorateId: event.governorateId ?? state.governorateId,
          propertyType: event.propertyType ?? state.propertyType,
        ),
        onData: (rentals) {
          emit(state.copyWith(
            status: LoadStatus.loaded,
            rentals: rentals,
            governorateId: event.governorateId,
            propertyType: event.propertyType,
          ));
        },
        onError: (error, stacktrace) {
          emit(state.copyWith(
            status: LoadStatus.error,
            error: (error as dynamic).message,
          ));
        },
      );

  FutureOr<void> _onClearRegionFilter(
    ClearRegionFilter event,
    Emitter<RentalsState> emit,
  ) =>
      emit.onEach<List<Rental>>(
        _repository.getRentals(propertyType: state.propertyType),
        onData: (rentals) {
          emit(state.copyWith(
            status: LoadStatus.loaded,
            rentals: rentals,
            governorateId: 0,
          ));
        },
        onError: (error, stacktrace) {
          emit(state.copyWith(
            status: LoadStatus.error,
            error: (error as dynamic).message,
          ));
        },
      );

  FutureOr<void> _onClearPropertyTypeFilter(
    ClearPropertyTypeFilter event,
    Emitter<RentalsState> emit,
  ) =>
      emit.onEach<List<Rental>>(
        _repository.getRentals(governorateId: state.governorateId),
        onData: (rentals) {
          emit(state.copyWith(
            status: LoadStatus.loaded,
            rentals: rentals,
          ));
        },
        onError: (error, stacktrace) {
          emit(state.copyWith(
            status: LoadStatus.error,
            error: (error as dynamic).message,
          ));
        },
      );
}
