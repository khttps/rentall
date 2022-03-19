import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/enums/enums.dart';
import '../../../data/repositories/rental_repository.dart';

import '../../../data/models/models.dart';

part 'rentals_event.dart';
part 'rentals_state.dart';

class RentalsBloc extends Bloc<RentalsEvent, RentalsState> {
  final RentalRepository _repository;
  RentalsBloc({required RentalRepository repository})
      : _repository = repository,
        super(RentalsLoading()) {
    on<GetRentals>((event, emit) async {
      await emit.onEach<List<Rental>>(
        _repository.getRentals(
          propertyType: event.propertyType,
          rentType: event.rentType,
          governorateId: event.governorateId,
          regionId: event.regionId,
          priceFrom: event.priceFrom,
          priceTo: event.priceTo,
        ),
        onData: (rentals) {
          emit(RentalsLoaded(rentals));
        },
      );
    });
  }
}
