  class GenreData {
    final List<String> movieTitles;
    final List<String> imagePaths;
    final List<String> routes;

    GenreData(this.movieTitles, this.imagePaths, this.routes);
  }

  GenreData getGenreData(String difficulty, String genre) {
    switch (difficulty) {
      case 'Easy':
        switch (genre) {
          case 'Romance':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/genre1scene',
              ],
            );
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Adventure':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          default:
            throw Exception('Invalid genre: $genre');
        }
      case 'Intermediate':
        switch (genre) {
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          case 'Comedy':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Adventure':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          default:
            throw Exception('Invalid genre: $genre');
        }
      case 'Hard':
        switch (genre) {
          case 'Comedy':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Adventure':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
            case 'Biographies':
            return GenreData(
            [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          default:
            throw Exception('Invalid genre: $genre');
        }
      default:
        throw Exception('Invalid difficulty: $difficulty');
    }
  }