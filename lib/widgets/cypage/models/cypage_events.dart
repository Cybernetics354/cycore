part of cypage;

abstract class CypageEvent {}

/// Use this event to send reload event to controllers
class CypageReload<T> extends CypageEvent {
  T? data;

  CypageReload({
    this.data,
  });
}

/// Use this event to send fetch event to controllers
class CypageFetch<T> extends CypageEvent {
  T? data;

  CypageFetch({
    this.data,
  });
}
