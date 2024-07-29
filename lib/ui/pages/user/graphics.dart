// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:langspeak/ui/shared/graphics/time_series_data.dart';

// class SimpleTimeSeriesChart extends StatelessWidget {
//   final List<charts.Series<TimeSeriesMessages, DateTime>> seriesList;
//   final bool animate;

//   const SimpleTimeSeriesChart(this.seriesList, {super.key, this.animate = false});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 300.0, // Ajusta el ancho aquí
//         height: 200.0, // Ajusta el alto aquí
//         child: charts.TimeSeriesChart(
//           seriesList,
//           animate: animate,
//           dateTimeFactory: const charts.LocalDateTimeFactory(),
//         ),
//       ),
//     );
//   }

// }