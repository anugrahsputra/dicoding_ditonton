import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/on_the_air_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air';

  @override
  State<OnTheAirPage> createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvNotifier>(context, listen: false)
          ..fetchOnTheAirTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv, index);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
