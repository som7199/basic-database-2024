-- NULL에 대한 고찰
-- MyBook 테이블에서 시작
SELECT bookid
     , price + 100
  FROM MyBook;

-- NULL은 집계에 들어가지 않음
-- 합계, 전체의 COUNT는 문제X, 평균에서와 price COUNT는 NULL값이 빠짐
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook;

SELECT (10000 + 20000 + 0) / 3;

-- bookid가 없는 데이터로 통계를 낼 때는 NULL이 나와야 함
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook
 WHERE bookid >= 4;

-- NULL 비교(!)
-- NULL은 일반 비교연산자로 비교X
-- IS / IS NOT
SELECT *
  FROM MyBook
 WHERE price IS NULL;

SELECT *
  FROM MyBook
 WHERE price IS NOT NULL;

-- ISNULL() 함수 : NULL인 데이터를 다른 값으로 치환
-- 사전 작업(Customer 테이블)
SELECT *
  FROM Customer
 WHERE phone IS NULL;

UPDATE Customer
   SET phone = NULL
 WHERE custid = 2;

SELECT custid
     , [name]
     , [address]
     , ISNULL(phone, '연락처 없음') AS phone    -- 표기만 연락처 없음이고 DB상에선 여전히 NULL!!
  FROM Customer;