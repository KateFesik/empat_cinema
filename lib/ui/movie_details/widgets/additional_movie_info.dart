import 'package:cinema/data/network/model/movie.dart';
import 'package:flutter/material.dart';

class AdditionalMovieInfo extends StatelessWidget {
  final Movie movie;

  const AdditionalMovieInfo({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(10),
      },
      children: [
        TableRow(
          children: [
            const PaddingCellText(child: Text("Director")),
            PaddingCellText(child: Text(movie.director)),
          ],
        ),
        TableRow(
          children: [
            const PaddingCellText(
              child: Text("Screenwriter"),
            ),
            PaddingCellText(
              child: Text(movie.screenwriter),
            ),
          ],
        ),
        TableRow(
          children: [
            const PaddingCellText(
              child: Text("Studio"),
            ),
            PaddingCellText(
              child: Text(movie.studio),
            ),
          ],
        ),
        TableRow(
          children: [
            const PaddingCellText(
              child: Text("Starring"),
            ),
            PaddingCellText(
              child: Text(movie.starring),
            ),
          ],
        ),
      ],
    );
  }
}

class PaddingCellText extends StatelessWidget {
  final Widget child;

  const PaddingCellText({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: child,
    );
  }
}
