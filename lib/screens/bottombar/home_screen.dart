import 'package:flutter/material.dart';
import 'package:lilac_movie_app/api/movie_service.dart';
import 'package:lilac_movie_app/models/movie_model.dart';
import 'package:lilac_movie_app/screens/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();

  List<Movie> movieslist = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    // loadMovies();
    getMovies();
  }

  Future<void> loadMovies() async {
    try {
      final result = await _movieService.fetchMovies('avengers');

      setState(() {
        movieslist = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  final movieService = MovieService();

  void getMovies() async {
    try {
      final result = await movieService.fetchMovies("avengers");

      setState(() {
        movieslist = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade800,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : error.isNotEmpty
            ? Center(
                child: Text(error, style: const TextStyle(color: Colors.white)),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///  Search Bar
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Search Movie",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///  Banner
                    Container(
                      height: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage("assets/home_banner.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ///  Category Chips
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          ChipWidget("Drama"),
                          ChipWidget("12+"),
                          ChipWidget("Action"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔥 Horizontal Movies
                    buildSectionTitle("Trending Movie Near You"),
                    const SizedBox(height: 10),
                    buildHorizontalList(),

                    const SizedBox(height: 20),

                    /// 🎥 Upcoming
                    buildSectionTitle("Upcoming"),
                    const SizedBox(height: 10),
                    buildHorizontalList(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  /// Section Title
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Horizontal Movie List (USING API DATA )
  Widget buildHorizontalList() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieslist.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final movie = movieslist[index];

          return InkWell(
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MovieDetailScreen(movie: movie),
    ),
  );
},
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(movie.poster),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

///  Chip Widget
class ChipWidget extends StatelessWidget {
  final String text;
  const ChipWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
