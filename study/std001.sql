SELECT *
  FROM Customer;

SELECT *
  FROM Orders;

SELECT *
  FROM Book;

SELECT new.name AS "30000원 이상 구매한 고객"
FROM (SELECT c.name, SUM(o.saleprice) AS "총 구매액"
  FROM Orders o, Customer c, Book b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid
 GROUP BY c.name) AS new
WHERE new.[총 구매액] >= 30000;

SELECT custid, SUM(saleprice) AS "총 구매액", COUNT(*) AS "도서 수량"
  FROM Orders
 GROUP BY custid;

-- 가격이 8000원 이상인 도서를 2권 이상 구매한 고객
SELECT custid, COUNT(*) AS "도서수량"
  FROM Orders
 WHERE saleprice >= 8000
 GROUP BY custid
 HAVING COUNT(*) >= 2;

-- 여러 개의 테이블을 이용하여 질의하는 두 가지 방법
-- 1) 조인
-- 조건 없이 조인해버리면 카티션 프로덕트 연산이 됨!
-- 투플 5개짜리 테이블이랑 10개짜리 테이블 조인하면 투플 50개 됨..!
-- 그러니 WHERE절에 조건을 주기!
SELECT *
  FROM Customer c, Orders o, Book b
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;

SELECT c.custid, COUNT(*) AS "구매 도서의 수"
  FROM Customer c, Orders o
 WHERE c.custid = o.custid
 GROUP BY c.custid;

-- 고객별 주문한 도서의 총 판매액
SELECT c.name, SUM(o.saleprice) AS "총 판매액"
  FROM Customer c, Orders o
 WHERE c.custid = o.custid
 GROUP BY c.name;

-- 고객의 이름과 고객이 주문한 도서
SELECT c.name, b.bookname
  FROM Customer c, Orders o, Book b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid
 ORDER BY c.name;

-- 가격이 20,000인 도서를 주문한 고객의 이름과 도서의 이름
SELECT c.name, b.bookname
  FROM Customer c, Orders o, Book b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid
   AND o.saleprice = 20000

-- 도서를 구매하지 않은 고객을 포함한 고객 이름과 고객이 주문한 도서의 판매가격
SELECT c.name, o.saleprice
  FROM Customer c LEFT OUTER JOIN Orders o
                  ON c.custid = o.custid;

-- 아 Customer DB에 값을 추가해줬네 ㅎ
SELECT *
  FROM Customer c LEFT OUTER JOIN Orders o
                  ON c.custid = o.custid;

-- 2) 서브쿼리