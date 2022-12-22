import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

class OnTheAirPage extends StatefulWidget {
  static const routeName = '/on-the-air';

  @override
  State<OnTheAirPage> createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<OnTheAirBloc>().add(OnTheAir()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirBloc, TvState>(
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
