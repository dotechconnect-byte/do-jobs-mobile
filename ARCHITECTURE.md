# Clean Architecture + BLoC Pattern

```
Presentation Layer (Screens / Widgets)
        ↓
Business Logic Layer (BLoCs / Cubits)
        ↓
Data Layer (Repositories / API Classes)
```

## Project Structure

```
/features/[feature_name]/
├── /presentation
│   ├── /screens       # UI pages
│   ├── /bloc          # BLoC, Events, States
│   └── /widgets       # Feature-specific widgets
├── /data
│   ├── /remote_repo   # API data sources
│   └── /model         # JSON-serialized data models
```

## Key Dependencies

| Category | Package | Purpose |
|----------|---------|---------|
| State Management | `flutter_bloc` | BLoC pattern |
| HTTP Client | `dio` | Networking with interceptors |
| DI | `get_it` | Service locator |
| Routing | `go_router` | Declarative routing |
| FP | `dartz` | Either/Result pattern |
| Storage | `flutter_secure_storage`, `shared_preferences` | Token & data persistence |
| Serialization | `json_serializable` | Code-gen JSON models |
| UI | `flutter_screenutil`, `fl_chart`, `data_table_2` | Responsive, charts, tables |
| Real-time | `socket_io_client` | WebSocket notifications |

## Architecture Patterns

### API Layer

- **BaseApi** abstract class handles all HTTP methods (GET, POST, PATCH, PUT, DELETE)
- Error handling via `Either<Failure, T>` from dartz

### State Management (BLoC)

```dart
// Events → BLoC → States
CallBusinessListingEvent → BusinessListingBloc → BusinessListingSuccess/Failed

// States follow: Initial → Loading → Success | Failed
// All API results use: result.fold((failure) => ..., (success) => ...)
```

### Dependency Injection (GetIt)

- **Factory:** BLoCs (new instance per widget)
- **LazySingleton:** API classes, repositories
- **Singleton:** Core services (Dio, CacheService)

## Conventions

- **Files:** `snake_case.dart`
- **Classes:** `PascalCase`
- **BLoC Events:** `Call[Action]Event`
- **BLoC States:** `[Entity]Initial / Loading / Success / Failed`
- **API classes:** extend `BaseApi`, registered as `LazySingleton`
- **Models:** `@JsonSerializable()` with `.g.dart` generated files
