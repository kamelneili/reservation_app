import 'package:mypfeapp/blocs/category/category_event.dart';
import 'package:mypfeapp/blocs/category/category_state.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/home/repositories/actualite_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvents, CategoryState> {
  final ActualiteRepository _actRepository;

  @override
  CategoryBloc({required actRepository})
      : _actRepository = actRepository,
        super(CategoryProductLoadingState()) {
    on<LoadCategoryProductEvent>(_onLoadCategoryProductEvent);
    //  on<DisplayRateProductEvent>(_onDisplayRateProductEvent);
  }
  // void _onLoadProductsEvent(
  //   LoadProductEvent event,
  //   Emitter<CategoryState> emit,
  // ) {
  //   emit(ProductLoadingState());LoadingCategoryProductEvent
  // }

  ///*******display category product */
  void _onLoadCategoryProductEvent(
    LoadCategoryProductEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryProductLoadingState());
    final List<Actualite> acts =
        await _actRepository.fetchCategoryProducts(event.category).first;
    print('actscaaat');
    print(acts);
    {
      emit(CategoryProductLoadedState(acts: acts));
    }
  }
}
