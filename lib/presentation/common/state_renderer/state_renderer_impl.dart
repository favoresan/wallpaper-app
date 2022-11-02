import 'package:wallpaper_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';
import '../../../data/mapper/mapper.dart';
import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//loading state (popup,fullscreen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//error state (popup ,full loading)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//content state
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

//empty state
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType: getStateRendererType(),
            message: getMessage(),
          );
        }
      case EmptyState:
        {
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType: getStateRendererType(),
            message: getMessage(),
          );
        }
      case ErrorState:
        {
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType: getStateRendererType(),
            message: getMessage(),
          );
        }
      case ContentState:
        {
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }
}
