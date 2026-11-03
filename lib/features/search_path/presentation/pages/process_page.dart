import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_searcher/common/di/di.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/managers/home_page_cubit.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/managers/process_page_cubit.dart';

class ProcessPage extends StatelessWidget {
  const ProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.read<HomePageCubit>().state;
    return BlocProvider(
      create: (_) => getIt<ProcessPageCubit>()..calculate(homeState.fields),
      child: _ProcessView(url: homeState.url ?? ''),
    );
  }
}

class _ProcessView extends StatelessWidget {
  const _ProcessView({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Process screen')),
      body: BlocConsumer<ProcessPageCubit, ProcessPageState>(
        listenWhen: (previous, current) =>
            previous.status != current.status && current.status == ProcessStatus.sent,
        listener: (context, state) {
          // TODO: navigate to result list screen
        },
        builder: (blockContext, state) {
          final isCalculating = state.status == ProcessStatus.calculating;
          final isSending = state.status == ProcessStatus.sending;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isCalculating
                              ? 'Calculating...'
                              : 'All calculations has finished, you can send your results to server',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${(state.progress * 100).round()}%',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(value: state.progress),
                        ),
                      ],
                    ),
                  ),
                  if (state.errorMessage != null) ...[
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (!isCalculating)
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isSending
                            ? null
                            : () => blockContext.read<ProcessPageCubit>().sendResults(url),
                        child: isSending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Send results to server'),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
