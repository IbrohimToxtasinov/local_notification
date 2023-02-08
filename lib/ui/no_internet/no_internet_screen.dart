import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/state_managers/cubit/connectivity/connectivity_cubit.dart';
import 'package:local_notification/utils/app_lotties.dart';
import 'package:lottie/lottie.dart';


class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key, required this.voidCallback})
      : super(key: key);

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: LottieBuilder.asset(
                  AppLotties.noInternet,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            BlocListener<ConnectivityCubit, ConnectivityState>(
              listener: (context, state) {
                if (state.connectivityResult != ConnectivityResult.none) {
                  voidCallback.call();
                  Navigator.pop(context);
                }
              },
              child: const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}