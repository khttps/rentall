import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/screens/blocs.dart';
import 'package:rentall/widgets/empty_list.dart';
import 'package:rentall/widgets/error_snackbar.dart';
import 'package:rentall/widgets/loading_widget.dart';

import '../../screens.dart';

class AlertsScreen extends StatelessWidget {
  static const routeName = '/alerts';
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts')),
      body: RefreshIndicator(
        onRefresh: () async {
          final bloc = context.read<AlertsBloc>()..add(const LoadAlerts());
          await bloc.stream.first;
        },
        child: BlocConsumer<AlertsBloc, AlertsState>(
          listener: (context, state) {
            if (state.status == AlertsStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(message: state.message!),
              );
            }
          },
          builder: (context, state) {
            if (state.status == AlertsStatus.loading) {
              return const LoadingWidget();
            } else if (state.status == AlertsStatus.loaded) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: state.alerts!.length,
                separatorBuilder: (c, i) =>
                    const Divider(thickness: 1.0, height: 0.0),
                itemBuilder: (context, index) {
                  final alert = state.alerts![index];
                  return ListTile(
                    title: Text(alert.keywords.join(', ')),
                    subtitle: Text(
                      DateFormat('d MMM, yyyy').format(
                        alert.createdAt!.toDate(),
                      ),
                    ),
                    trailing: Text(
                      'every ${alert.repeat} ${alert.repeat == 1 ? 'day' : 'days'}',
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AlertScreen.routeName,
                        arguments: alert,
                      );
                    },
                  );
                },
              );
            } else {
              return const EmptyList();
            }
          },
        ),
      ),
    );
  }
}
