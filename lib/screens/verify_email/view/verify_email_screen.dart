import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rentall/screens/home/home.dart';
import 'package:rentall/screens/verify_email/cubit/verify_email_cubit.dart';

class VerifyEmailScreen extends StatelessWidget {
  final bool first;
  static const routeName = '/verify_email';
  const VerifyEmailScreen({
    this.first = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify_email').tr(),
      ),
      body: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  first ? 'verify_first' : 'verift_second',
                  style: const TextStyle(fontSize: 16.0),
                ).tr(),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        primary: state is ResendLoading ? Colors.grey : null,
                      ),
                      child: const Text('resend_email').tr(),
                      onPressed: () async {
                        if (state is! ResendLoading) {
                          await BlocProvider.of<VerifyEmailCubit>(context)
                              .sendVerificationEmail();
                        }
                      },
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      child: const Text('proceed').tr(),
                      onPressed: () {
                        Phoenix.rebirth(context);
                      },
                    ),
                  ],
                ),
                if (state is ResendLoading) ...[
                  const SizedBox(height: 24.0),
                  const Center(
                    child: CircularProgressIndicator(strokeWidth: 3.0),
                  )
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
