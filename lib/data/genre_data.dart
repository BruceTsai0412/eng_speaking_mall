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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
          case 'Romance':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'The Notebook',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_the_notebook.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
          case 'Romance':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
      case 'Phonetics 1':
        switch (genre) {
          case 'Romance':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
      case 'Phonetics 2':
        switch (genre) {
          case 'Romance':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
              ],
              [
                '/genre1scene',
                '/genre1scene2',
                '/genre1scene3',
                '/videotest',
              ],
            );
          case 'Sci-Fi':
            return GenreData(
              [
                'La La Land',
                'Love Happens',
                'Titanic',
                'Movie title 4',
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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
                'Movie title 5',
                'Movie title 6',
              ],
              [
                'image/pos_la_la_land.png',
                'image/pos_love_happens.png',
                'image/pos_titanic.png',
                'image/pos_la_la_land.png',
                'image/pos_la_la_land.png',
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