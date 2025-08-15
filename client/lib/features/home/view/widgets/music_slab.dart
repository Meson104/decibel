import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/view/widgets/music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    if (currentSong == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const MusicPlayer();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween =
                Tween(begin: const Offset(0, 1), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeIn),
            );
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 65,
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
              color: HexToColor(currentSong.hexColor),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'song-thumbnail',
                      child: Container(
                        width: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: NetworkImage(currentSong.thumbnail_url),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentSong.song_name,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            currentSong.artist,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Pallete.subtitleText,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.heart,
                        color: Pallete.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: songNotifier.playPause,
                      icon: Icon(
                        songNotifier.isPlaying
                            ? CupertinoIcons.pause_fill
                            : CupertinoIcons.play_fill,
                        color: Pallete.whiteColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          StreamBuilder(
              stream: songNotifier.audioPlayer?.positionStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                final position = snapshot.data;
                final duration = songNotifier.audioPlayer!.duration;
                double sliderValue = 0.0;
                if (position != null && duration != null) {
                  sliderValue =
                      position.inMilliseconds / duration.inMilliseconds;
                }

                return Positioned(
                  bottom: 0,
                  left: 8,
                  child: Container(
                    height: 2,
                    width:
                        sliderValue * (MediaQuery.of(context).size.width - 32),
                    decoration: BoxDecoration(
                        color: Pallete.whiteColor,
                        borderRadius: BorderRadius.circular(7)),
                  ),
                );
              }),
          Positioned(
            bottom: 0,
            left: 8,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                  color: Pallete.inactiveSeekColor,
                  borderRadius: BorderRadius.circular(7)),
            ),
          )
        ],
      ),
    );
  }
}
