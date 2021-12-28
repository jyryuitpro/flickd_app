import 'dart:ui';

import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/models/search_category.dart';
import 'package:flickd_app/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  double? _deviceHeight;
  double? _deviceWidth;

  TextEditingController? _searchTextFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _searchTextFieldController = TextEditingController();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
              'https://images-na.ssl-images-amazon.com/images/I/91B32iU7ayL._AC_SL1500_.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15.0,
          sigmaY: 15.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  Widget _foregroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight! * 0.02, 0, 0),
      width: _deviceWidth! * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _tobBarWidget(),
          Container(
            height: _deviceHeight! * 0.83,
            padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
            child: _moviesListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _tobBarWidget() {
    return Container(
      height: _deviceHeight! * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth! * 0.50,
      height: _deviceHeight! * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: (_input) {},
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          focusedBorder: _border,
          border: _border,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white24,
          ),
          hintStyle: TextStyle(
            color: Colors.white54,
          ),
          filled: false,
          fillColor: Colors.white24,
          hintText: 'Search...',
        ),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      icon: Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (_value) {},
      items: [
        DropdownMenuItem(
          child: Text(
            SearchCategory.popular,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          value: SearchCategory.popular,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          value: SearchCategory.upcoming,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.none,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          value: SearchCategory.none,
        ),
      ],
    );
  }

  Widget _moviesListViewWidget() {
    final List<Movie> _movies = [];

    for (var i = 0; i < 20; i++) {
      _movies.add(Movie(
        name: 'Mortal Kombat',
        language: 'EN',
        isAdult: false,
        decription:
            'Washed-up MMA fighter Cole Young, unaware of his heritage, and hunted by Emperor Shang Tsung\'s best warrior, Sub-Zero, seeks out and trains with Earth\'s greatest champions as he prepares to stand against the enemies of Outworld in a high stakes battle for the universe.',
        posterPath: '/nkayOAUBUu4mMvyNf9iHSUiPjF1.jpg',
        backdropPath: '/9yBVqNruk6Ykrwc32qrK2TIE5xw.jpg',
        rating: 7.8,
        releaseDate: '2021-04-07',
      ));
    }

    if (_movies.length != 0) {
      return ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (_context, _count) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: _deviceHeight! * 0.01,
              horizontal: 0,
            ),
            child: GestureDetector(
              onTap: () {},
              child: MovieTile(
                height: _deviceHeight! * 0.20,
                width: _deviceWidth! * 0.85,
                movie: _movies[_count],
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
