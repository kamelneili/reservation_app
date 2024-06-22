import 'package:bloc/bloc.dart';
import 'package:mypfeapp/blocs/search/search_event.dart';
import 'package:mypfeapp/blocs/search/search_state.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/repositories/search_repository.dart';

class SearchBloc extends Bloc<SearchEvents, SearchState> {
  final SearchRepository _searchRepository;

  @override
  SearchBloc({required searchRepository})
      : _searchRepository = searchRepository,
        super(ProductLoadingState()) {
    on<SearchProductEvent>(_onSearchProductEvent);
  }

  ///*******search product */
  void _onSearchProductEvent(
    SearchProductEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final List<Actualite> acts =
          await _searchRepository.fetchSearchedProduct(event.query).first;

      {
        emit(ProductSearchedState(products: acts));
      }
    } catch (_) {
      emit(ProductLodingErrorState("auth error"));
    }
  }
}
