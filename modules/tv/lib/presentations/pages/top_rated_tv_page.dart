import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class TopRatedTvPage extends StatefulWidget {
  static const routeName = '/top_rated_tv_page';

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TopRatedBloc>().add(TopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvListHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvList[index];
                  return TvCard(tv, index);
                },
                itemCount: state.tvList.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
