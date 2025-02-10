import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';

class MockCreateBatchUseCase extends Mock implements CreateBatchUseCase {}

class MockGetAllBatchUseCase extends Mock implements GetAllBatchUseCase {}

class MockDeleteBatchUseCase extends Mock implements DeleteBatchUsecase {}

void main() {
  late CreateBatchUseCase createBatchUseCase;
  late GetAllBatchUseCase getAllBatchUseCase;
  late DeleteBatchUsecase deleteBatchUsecase;
  late BatchBloc batchBloc;

  setUp(() {
    createBatchUseCase = MockCreateBatchUseCase();
    getAllBatchUseCase = MockGetAllBatchUseCase();
    deleteBatchUsecase = MockDeleteBatchUseCase();

    batchBloc = BatchBloc(
      createBatchUseCase: createBatchUseCase,
      getAllBatchUseCase: getAllBatchUseCase,
      deleteBatchUsecase: deleteBatchUsecase,
    );
  });

  // group('BatchBloc', () {
  final batch = BatchEntity(batchName: 'Batch 1', batchId: '1');
  final batch2 = BatchEntity(batchName: 'Batch 2', batchId: '2');
  final lstBatches = [batch, batch];

  blocTest<BatchBloc, BatchState>(
      'emits [BatchState] with loaded batches when LoadBbatches is added',
      build: () {
        when(() => getAllBatchUseCase.call())
            .thenAnswer((_) async => Right(lstBatches));
        return batchBloc;
      },
      act: (bloc) => bloc.add(LoadBatches()),
      expect: () => [
            BatchState.initial().copyWith(isLoading: true),
            BatchState.initial()
                .copyWith(isLoading: false, batches: lstBatches),
          ],
      verify: (_) {
        verify(() => getAllBatchUseCase.call()).called(1);
      });

  blocTest<BatchBloc, BatchState>(
      'emits [BatchState] with loaded batches when LoadBbatches is added with skip 1',
      build: () {
        when(() => getAllBatchUseCase.call())
            .thenAnswer((_) async => Right(lstBatches));
        return batchBloc;
      },
      act: (bloc) => bloc.add(LoadBatches()),
      skip: 1,
      expect: () => [
            BatchState.initial()
                .copyWith(isLoading: false, batches: lstBatches),
          ],
      verify: (_) {
        verify(() => getAllBatchUseCase.call()).called(1);
      });
}
