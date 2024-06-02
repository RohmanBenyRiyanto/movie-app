import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../app/res/res.dart';
import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import '../../domain/entity/movie_list_entity.dart';

class MovieDetailBottomSheet extends StatefulWidget {
  const MovieDetailBottomSheet({super.key, this.movie});

  final ResultEntity? movie;

  @override
  State<MovieDetailBottomSheet> createState() => _MovieDetailBottomSheetState();
}

class _MovieDetailBottomSheetState extends State<MovieDetailBottomSheet> {
  final String url = "https://www.youtube.com/watch?v=jnCefPQIH98";

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final id = YoutubePlayer.convertUrlToId(url)!;

    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);

    super.initState();
  }

  void listener() {
    if (_controller.value.isReady && mounted) {
      _controller.play(); // Memulai pemutaran setelah video siap
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  _controller.play(); // Memulai pemutaran setelah video siap
                },
              ),
              builder: (context, player) {
                return player;
              },
            ),
          ),
        ),
        const SizedBox(height: AppDimens.s12),
        Text(
          widget.movie?.title ?? "-",
          style: AppTextStyle.label1Bold.copyWith(
            color: AppColor.textPrimary,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 2,
        ),
        const SizedBox(height: AppDimens.s10),
        Text(
          widget.movie?.overview ?? "-",
          style: AppTextStyle.label3Light.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}

Future<AppBottomSheet> showMovieDetail(
  BuildContext context, {
  ResultEntity? movie,
}) async {
  return await AppBottomSheet.show(
    context: context,
    builder: (context) => MovieDetailBottomSheet(movie: movie),
  );
}
