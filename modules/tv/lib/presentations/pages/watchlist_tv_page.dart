import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

// ignore: use_key_in_widget_constructors
class WatchlistTvPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const routeName = '/watchlist-tv';

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvNotifier>(context, listen: false)
          ..fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvNotifier>(
          builder: (context, data, child) {
            if (data.watchListState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchListState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.watchListTv[index];
                  return TvCard(tv, index);
                },
                itemCount: data.watchListTv.length,
              );
            } else if (data.watchListState == RequestState.Error) {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            } else {
              return Center(
                child: Text('You don\'t have Watchlist', style: kHeading5),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
