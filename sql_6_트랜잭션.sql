-------------------------------Transaction (트랜잭션)-------------------------------
/*
    commit 
        - 모든 작업들을 정상적으로 처리하겠다고 확정하는 명령어로
          트랜잭션의 처리과정을 데이터베이스에 모두 반영하기 위해서 변경된 내용을 영구 저장함
          
    rollback
        - 작업중 문제가 발생되어서 트랜잭션의 처리 과정에서 발생한 변경 사항을 취소하는 명령
          이전의 상태로 되돌림

    savepoint
        - 현재의 트랜잭션을 작게 분할하여 처리함
          저장된 savepoint는 rollback to savepoint 문을 사용하여 표시한 곳까지 rollback 가능
*/

delete from dept01;

select * from tab;
select * from dept01;

rollback;

commit; -- 작업 확정. rollback으로 되돌릴 수 없음.

savepoint cori;
--현재 상태 저장, 여기에는 기존에 지정해 놓은 savepoint가 포함됨
--따라서 이후 생성했었던 savepoint는 전부 날아감

delete from dept01 where deptno = 30;
savepoint c1;
delete from dept01 where deptno = 20;
savepoint c2;
delete from dept01 where deptno = 10;
savepoint c3;

select * from dept01;

rollback to c1;
rollback to c2;
/*

*/