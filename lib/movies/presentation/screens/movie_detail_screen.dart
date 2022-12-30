import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../../domain/entities/genres.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetMovieCastEvent(id)),
      child: const Scaffold(
        body: MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.requestState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          case RequestState.loaded:
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: FadeIn(
                            duration: const Duration(milliseconds: 350),
                            child: ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.5, 1.0, 1.0],
                                ).createShader(
                                  Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width,
                                imageUrl: ApiConstants.imageUrl(
                                    state.movieDetail!.backdropPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 350),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.movieDetail!.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    )),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        state.movieDetail!.releaseDate.split('-')[0],
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          (state.movieDetail!.voteAverage / 2)
                                              .toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          '(${state.movieDetail!.voteAverage})',
                                          style: const TextStyle(
                                            fontSize: 1.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16.0),
                                    Text(
                                      _showDuration(state.movieDetail!.runtime),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  state.movieDetail!.overview,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '${AppStrings.genres}: ${_showGenres(state.movieDetail!.genres)}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 350),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0,0),
                            child: Text(
                              AppStrings.movieCast.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0,0, 16.0, 24.0),
                          child: _showCast(),
                        )
                      ]
                  ),
                  Positioned(
                      top: 30,
                      child: IconButton(
                        splashRadius: 22,
                          onPressed: ()
                      {
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back_outlined, color: Colors.white, size: 26,)))
                ],
              ),
            );
          case RequestState.error:
            return Center(child: Text(state.message));
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showCast() {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.castRequestState) {
          case RequestState.loading:
            return const SizedBox();
          case RequestState.loaded:
            return FadeInUp(
              duration: const Duration(milliseconds: 350),
              child: GridView.builder(
                itemCount: state.movieCast?.length,
                physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemBuilder: (context, index)
                {
                  final cast = state.movieCast![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10.0)),
                        child: CachedNetworkImage(
                          imageUrl: ApiConstants.imageUrl(cast.profilePath!),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[850]!,
                            highlightColor: Colors.grey[800]!,
                            child: Container(
                              height: 170.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          height: 180.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        cast.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )
                    ],
                  );
                }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 9.0,
                crossAxisSpacing: 3.0,
                mainAxisExtent: 215.0,
                childAspectRatio: 0.7,
                crossAxisCount: 3,
              ),
              ),
            );
          case RequestState.error:
            return Center(child: Text(state.castMessage));
        }
      },
    );
  }
}
