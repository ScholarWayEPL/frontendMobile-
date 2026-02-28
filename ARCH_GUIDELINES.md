# Project Architecture & Contribution Guidelines

Respect the following architectural order and separation of responsibilities for any new feature or integration:

1. **Datasources**: Implementation of data fetching (Remote/Local). Use **Dio** for HTTP requests with appropriate **Interceptors**.
2. **Repository (Domain)**: Abstract interface defining the contract for data operations.
3. **Repository Implementation (Data)**: Concrete implementation of the domain repository, coordinating between different datasources.
4. **Usecases (Domain)**: Individual classes for each business operation.
5. **Provider (Presentation)**: Riverpod state management and dependency injection.
6. **UI (Presentation)**: Flutter widgets consuming the providers and displaying data.

Always follow this sequence: **Datasource -> Repository -> Repository Impl -> Usecase -> Provider -> UI**.
