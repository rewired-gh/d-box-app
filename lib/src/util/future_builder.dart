import 'package:flutter/material.dart';

AsyncWidgetBuilder<T> autoWaitBuilderRoutine<T>(AsyncWidgetBuilder<T> builder,
    {bool? otherWait}) {
  return (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting ||
        otherWait == true) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text(snapshot.error.toString()));
    }
    return builder(context, snapshot);
  };
}
