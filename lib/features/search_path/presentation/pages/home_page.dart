import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shortest_path_searcher/common/routing/routing.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/managers/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    final savedUrl = context.read<HomePageCubit>().state.url;
    _urlController = TextEditingController(text: savedUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _onStart() {
    FocusScope.of(context).unfocus();
    context.read<HomePageCubit>().start(_urlController.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home screen')),
        body: MultiBlocListener(
          listeners: [
            BlocListener<HomePageCubit, HomePageState>(
              listenWhen: (previous, current) =>
                  previous.url != current.url &&
                  current.url != null &&
                  _urlController.text.isEmpty,
              listener: (_, state) => _urlController.text = state.url!,
            ),
            BlocListener<HomePageCubit, HomePageState>(
              listenWhen: (previous, current) =>
                  current.errorMessage != null && previous.errorMessage != current.errorMessage,
              listener: (context, state) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              },
            ),
            BlocListener<HomePageCubit, HomePageState>(
              listenWhen: (previous, current) => !previous.isLoaded && current.isLoaded,
              listener: (context, state) => context.pushNamed(RouteName.processScreen),
            ),
          ],
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (blockContext, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Set valid API base URL in order to continue'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.compare_arrows),
                          SizedBox(width: 16,),
                          Expanded(
                            child: TextField(
                              controller: _urlController,
                              enabled: !state.isLoading,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              autocorrect: false,
                              decoration: InputDecoration(
                                errorText: state.validationError,
                              ),
                              onChanged: blockContext.read<HomePageCubit>().onUrlChanged,
                              onSubmitted: (_) => _onStart(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: state.isLoading ? null : _onStart,
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Start counting process'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
