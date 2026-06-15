import 'package:flutter/foundation.dart';

class IsolateParser {
  IsolateParser._();

  static Future<Result> run<Message, Result>(
    ComputeCallback<Message, Result> parser,
    Message message,
  ) {
    return compute(parser, message);
  }
}
