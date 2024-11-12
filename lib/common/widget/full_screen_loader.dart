import 'package:flutter/material.dart';

class EnhancedLoadingWrapper extends StatelessWidget {
  const EnhancedLoadingWrapper({
    required this.child,
    required this.isLoading,
    super.key,
  });

  final Widget child;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return Stack(
      children: [
        child,
        if (isLoading)
          Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color: Colors.blue.withOpacity(0.5),
              ),
              const Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Align(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}