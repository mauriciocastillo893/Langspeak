// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:langspeak/ui/shared/graphics/time_series_data.dart';

// List<charts.Series<TimeSeriesMessages, DateTime>> createData() {
//   final data = [
//   TimeSeriesMessages(DateTime(2023, 7, 19), 5),
//   TimeSeriesMessages(DateTime(2023, 7, 26), 25),
//   TimeSeriesMessages(DateTime(2023, 8, 2), 100),
//   TimeSeriesMessages(DateTime(2023, 8, 9), 75),
//   TimeSeriesMessages(DateTime(2023, 8, 16), 88),
//   TimeSeriesMessages(DateTime(2023, 8, 23), 65),
//   TimeSeriesMessages(DateTime(2023, 8, 30), 91),
//   TimeSeriesMessages(DateTime(2023, 9, 6), 100),
//   TimeSeriesMessages(DateTime(2023, 9, 13), 111),
//   TimeSeriesMessages(DateTime(2023, 9, 20), 90),
//   TimeSeriesMessages(DateTime(2023, 9, 27), 100),
//   TimeSeriesMessages(DateTime(2023, 10, 4), 75),
//   TimeSeriesMessages(DateTime(2023, 10, 11), 88),
//   TimeSeriesMessages(DateTime(2023, 10, 18), 65),
//   TimeSeriesMessages(DateTime(2023, 10, 25), 91),
//   TimeSeriesMessages(DateTime(2023, 11, 1), 100),
//   TimeSeriesMessages(DateTime(2023, 11, 8), 111),
//   TimeSeriesMessages(DateTime(2023, 11, 15), 90),
//   ];

//   return [
//     charts.Series<TimeSeriesMessages, DateTime>(
//       id: 'Sales',
//       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//       domainFn: (TimeSeriesMessages sales, _) => sales.time,
//       measureFn: (TimeSeriesMessages sales, _) => sales.messages,
//       data: data,
//     )
//   ];
// }