class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String apiKey = '556bd62015407655b3465b5bfeaaa0df';

  static const String nowPlayingMoviesPath = '$baseUrl/movie/now_playing?api_key=$apiKey';

  static const String upcomingMoviesPath = '$baseUrl/movie/upcoming?api_key=$apiKey';

  static const String topRatedMoviesPath = '$baseUrl/movie/top_rated?api_key=$apiKey';

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500/';

  static const String categoriesStringPath = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';

  static String movieDetailsPath(int movieId) => 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';

  static String movieCastPath(int movieId) => 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

  static String imageUrl(String path) => '$baseImageUrl$path';
}
