
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:gronk/doamin/usecases/song/add_or_remove_favorite.dart';

import '../../../service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songID) async{

    var result = await sl<AddOrRemoveFavoriteSongUsecase>().call(
      params: songID
    );

    result.fold(
      (l){},
      (isFavorite){
        emit(
          FavoriteButtonUpdated(
            isFavorite: isFavorite
          )
        );
      }  
      );

  }

}