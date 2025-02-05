import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockBatchRepository repository;
  late GetAllBatchUseCase usecase;

  setUp(() {
    repository = MockBatchRepository();
    usecase = GetAllBatchUseCase(batchRepository: repository);
  });

  final tBatch = BatchEntity(
    batchName: 'Test Batch',
    batchId: '1',
  );

  final tBatch2 = BatchEntity(
    batchName: 'Test Batch 2',
    batchId: '2',
  );

  final tBatches = [tBatch, tBatch2];

  test('should get batches from repository', () async {
    when(() => repository.getBatches()).thenAnswer(
      (_) async => Right(tBatches),
    );

    //act
    final result = await usecase();

    //assert
    expect(result, Right(tBatches));

    //verify
    verify(() => repository.getBatches()).called(1);
  });
}
