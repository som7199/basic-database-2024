-- 트랜스액션(트랜잭션)
-- SELECT만 있으면 굳이 트랜잭션을 안 걸어도 됨
-- INSERT, UPDATE, DELETE에서 중요한 로직을 처리할 때 트랜잭션 반드시 필요
SELECT *
  FROM Customer;

-- 트랜잭션은 실수를 방지하기 위해서
BEGIN TRAN; --트랜잭션 시작

-- CUD에 대한 쿼리
UPDATE Customer
   SET phone = '010-7777-8888'
 WHERE custid = 2;

COMMIT;
ROLLBACK;

/*  BEGIN TRAN;을 했어야했는데..^^ 냅다 실행시켜서 다시 UPDATE 해주기..
UPDATE Customer
   SET phone = '000-5000-0001'
 WHERE custid = 1;

UPDATE Customer
   SET phone = '000-6000-0001'
 WHERE custid = 2;

UPDATE Customer
   SET phone = '000-7000-0001'
 WHERE custid = 3;

UPDATE Customer
   SET phone = '000-8000-0001'
 WHERE custid = 4;

UPDATE Customer
   SET phone = NULL
 WHERE custid = 5;
 */
