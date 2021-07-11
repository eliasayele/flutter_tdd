import 'package:tddapp/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:tddapp/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tddapp/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  late Widget showthis;
                  if (state is Empty) {
                    showthis = MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    showthis = LoadingWidget();
                  } else if (state is Loaded) {
                    showthis = TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    showthis = MessageDisplay(
                      message: state.message,
                    );
                  }
                  return showthis;
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
