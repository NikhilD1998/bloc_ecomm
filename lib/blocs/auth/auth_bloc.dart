import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:hive/hive.dart';

const _authBoxName = 'authBox';
const _authKey = 'isAuthenticated';
const _guestKey = 'isGuest';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<GuestLoginRequested>(_onGuestLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final box = await Hive.openBox(_authBoxName);
    final isAuthenticated = box.get(_authKey, defaultValue: false) as bool;
    final isGuest = box.get(_guestKey, defaultValue: false) as bool;
    if (isAuthenticated) {
      emit(Authenticated(isGuest: isGuest));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (event.email == 'user@example.com' && event.password == 'password123') {
      final box = await Hive.openBox(_authBoxName);
      await box.put(_authKey, true);
      await box.put(_guestKey, false);
      emit(Authenticated(isGuest: false));
    } else {
      emit(const Unauthenticated(error: 'Invalid credentials'));
    }
  }

  Future<void> _onGuestLoginRequested(
    GuestLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    final box = await Hive.openBox(_authBoxName);
    await box.put(_authKey, true);
    await box.put(_guestKey, true);
    emit(Authenticated(isGuest: true));
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final box = await Hive.openBox(_authBoxName);
    await box.put(_authKey, false);
    await box.put(_guestKey, false);
    emit(const Unauthenticated());
  }
}
