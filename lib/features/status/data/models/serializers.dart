library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:uncovid/features/status/data/models/models.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Status,
  Totals,
  Diffs,
  Stats,
  Versus,
  ResponseTopHeadlinesNews,
  Article,
  Source,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
