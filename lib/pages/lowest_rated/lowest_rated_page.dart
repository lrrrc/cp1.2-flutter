import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/lowest_rated/widgets/lowest_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

class LowestRatedPage extends StatefulWidget {
  const LowestRatedPage({super.key});

  @override
  State<LowestRatedPage> createState() => _LowestRatedPageState();
}

class _LowestRatedPageState extends State<LowestRatedPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> moviesFuture;

  @override
  void initState() {
    moviesFuture = apiServices.getLowestRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lowest Rated Movies'),
      ),
      body: FutureBuilder<Result>(
          future: moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.movies.length,
                itemBuilder: (context, index) {
                  return LowestRatedMovie(movie: snapshot.data!.movies[index]);
                },
              );
            }

            return const Center(
              child: Text('No data found'),
            );
          }),
    );
  }
}
