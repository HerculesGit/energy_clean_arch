abstract class FutureUseCase<Input, Output> {
  Future<Output> call({required Input params});
}
