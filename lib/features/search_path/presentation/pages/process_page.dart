import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shortest_path_searcher/common/di/di.dart';
import 'package:shortest_path_searcher/common/routing/routing.dart';
import 'package:shortest_path_searcher/common/widgets/app_button.dart';
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
        listener: (context, state) => context.pushNamed(
          RouteName.resultListScreen,
          extra: state.results,
        ),
        builder: (blockContext, state) {
          final isCalculating = state.status == ProcessStatus.calculating;
          final isSending = state.status == ProcessStatus.sending;
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          isCalculating
                              ? 'Calculating...'
                              : 'All calculations has finished, you can send your results to server',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(state.progress * 100).round()}%',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      const Divider(height: 24),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: state.progress,
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                if (!isCalculating)
                  AppButton(
                    text: 'Send results to server',
                    isLoading: isSending,
                    onPressed: () => blockContext.read<ProcessPageCubit>().sendResults(url),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

}
