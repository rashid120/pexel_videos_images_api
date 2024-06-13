import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyPlayer extends StatefulWidget{
  final String videoLink;
  const MyPlayer({super.key, required this.videoLink});
  @override
  State<MyPlayer> createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {

  late VideoPlayerController videoController;

  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoController  = VideoPlayerController.networkUrl(Uri.parse(widget.videoLink));
    videoController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: const Border(bottom: BorderSide(width: 1,color: Colors.red))
      ),
      child: Stack(
        children: [
          VideoPlayer(videoController),
          Center(child: IconButton(onPressed: (){
            setState(() {
              isPlay = !isPlay;
              if(isPlay){
                videoController.play();
              }else{
                videoController.pause();
              }
            });
          }, icon: isPlay ? const Text('') : Icon(isPlay ? Icons.pause_circle : Icons.play_circle, size: 45,)))
        ],
      ),
    );
  }
}