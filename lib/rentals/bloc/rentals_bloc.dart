import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
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
  }

  FutureOr<void> _onGetRentals(GetRentals event, emit) async {
    final governorate = _preferences.getInt('governorate');

    if (state.status != RentalsLoadStatus.loading) {
      emit(state.copyWith(
        status: RentalsLoadStatus.reloading,
        governorate: Governorate.values[governorate ?? 0],
      ));
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
}



// class RentalsBloc {
//   final RentalRepository _repository;
//   final SharedPreferences _preferences;
//   RentalsBloc({
//     required RentalRepository repository,
//     required SharedPreferences preferences,
//   })  : _repository = repository,
//         _preferences = preferences {
//     _rentalEventController.stream.listen((event) {
//       _mapEventToState(event);
//     });
//   }

//   final _rentalEventController = StreamController<RentalsEvent>();
//   void add(RentalsEvent event) {
//     _rentalEventController.sink.add(event);
//   }

//   List<Rental> _rentals = [];
//   int? _governorateId;
//   RentalType? _type;

//   final _rentalsStateController = StreamController<BlocState<List<Rental>>>();
//   StreamSink<BlocState<List<Rental>>> get _inRentals =>
//       _rentalsStateController.sink;
//   Stream<BlocState<List<Rental>>> get rentals async* {
//     yield const BlocState();
//     try {
//       yield* _rentalsStateController.stream;
//     } on Exception catch (err) {
//       yield BlocState(
//         status: LoadStatus.error,
//         error: (err as dynamic).message,
//       );
//     }
//   }

//   final _regionStateController = StreamController<int?>();
//   StreamSink<int?> get _inRegion => _regionStateController.sink;
//   Stream<int?> get region => _regionStateController.stream;

//   final _typeStateController = StreamController<RentalType?>();
//   StreamSink<RentalType?> get _inType => _typeStateController.sink;
//   Stream<RentalType?> get type => _typeStateController.stream;

//   void dispose() {
//     _rentalEventController.close();
//     _rentalsStateController.close();
//     _regionStateController.close();
//     _typeStateController.close();
//   }

//   Future<void> _mapEventToState(RentalsEvent event) async {
//     if (event is GetRentals) {
//       _governorateId = _preferences.getInt('governorateId');
//       _inRegion.add(_governorateId);
//     } else if (event is FilterRentalsByRegion) {
//       _governorateId = event.governorateId;
//       _preferences.setInt('governorateId', _governorateId!);
//       _inRegion.add(_governorateId);
//     } else if (event is FilterRentalsByPropertyType) {
//       _type = event.type;
//       _inType.add(_type);
//     } else if (event is ClearRegionFilter) {
//       _governorateId = null;
//       await _preferences.remove('governorateId');
//       _inRegion.add(_governorateId);
//     } else if (event is ClearPropertyTypeFilter) {
//       _type = null;
//       _inType.add(_type);
//     }
//     _rentals = await _repository.getRentals(
//       governorateId: _governorateId,
//       propertyType: _type,
//     );
//     _inRentals.add(BlocState(
//       status: LoadStatus.loaded,
//       data: _rentals,
//     ));
//   }
// }
