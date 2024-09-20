import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gronk/presentation/song_player/bloc/song_player_state.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  Duration buffersong = Duration.zero;
  
  SongPlayerCubit() : super(SongPlayerLoading()) {


    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

        
    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });

    audioPlayer.bufferedPositionStream.listen((buffer) {
      buffersong = buffer;
    });
  }

  void updateSongPlayer() {
    emit(
      SongPlayerLoaded()
    );
  }




  Future<void> loadSong(String url) async{

    try{
      
      await audioPlayer.setUrl(url);
      emit(
        SongPlayerLoaded()
      );
    
    } catch(e){
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong(){
    if(audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }

    emit(SongPlayerLoaded());
  }

  void setPosition(position) async{
    await audioPlayer.seek(Duration(seconds: position));
  }

  // Future<double> buffer() async{
  //   final buffer =  audioPlayer.bufferedPosition;
  //   final buff = buffer as double;
  //   return buff;
  // }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}

