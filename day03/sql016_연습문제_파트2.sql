-- 1. 주문하지 않은 고객의 이름(서브쿼리 사용)
SELECT [name] 
  FROM Customer
 WHERE custid NOT IN (SELECT DISTINCT custid
                        FROM Orders);

-- 2. 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice) AS '총 주문액'
     , AVG(saleprice) AS '주문 평균 금액'
  FROM Orders;

-- 3. 고객의 이름과 고객별 구매액
SELECT c.name, SUM(o.saleprice) AS '구매액'
 From Customer AS c, Orders AS o
WHERE c.custid = o.custid
GROUP BY c.name;

SELECT (SELECT name FROM Customer c WHERE c.custid = o.custid) AS '구매 고객'
     , SUM(saleprice) AS '고객별 구매액'
  FROM Orders AS o
 GROUP BY o.custid;

-- 4. 고객의 이름과 고객이 구매한 도서 목록
SELECT c.[name], b.bookname
  FROM Book b, Customer c, Orders o
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid
 ORDER BY c.[name];

-- 5. 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
SELECT TOP 1 o.orderid -- 1번째 컬럼
     , o.saleprice  -- 2번째 컬럼
     , b.price      -- 3번째 컬럼
     , (b.price - o.saleprice) AS '금액차' -- 4번째 컬럼
  FROM Orders o, Book b
 WHERE o.bookid = b.bookid
 --ORDER BY (b.price - o.saleprice) DESC;
 ORDER BY 4 DESC;

-- 6. 도서 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름(엥 이거 좀 어려웠다...! ㅠㅠ)
SELECT AVG(saleprice) AS '도서 판매액 평균'
  FROM Orders;

SELECT AVG(o.saleprice) AS '구매액 평균'
  FROM Orders as o, Customer as c
 WHERE c.custid = o.custid
 GROUP BY c.custid

SELECT b.avg AS '구매액 평균'
     , c.[name]
  FROM (SELECT AVG(o1.saleprice) AS avg
             , o1.custid
          FROM Orders AS o1
         GROUP BY o1.custid) AS b, Customer AS c
 WHERE b.custid = c.custid
   AND b.avg >= (SELECT AVG(saleprice)
                   FROM Orders); 

-- 두가지 방법
SELECT (SELECT [name] FROM Customer WHERE custid = base.custid) AS '고객명'
     , base.Average
  FROM (SELECT o.custid 
     , AVG(saleprice) AS Average
          FROM Orders AS o
         GROUP BY o.custid) AS Base
 WHERE base.Average >= (SELECT AVG(saleprice) AS '도서 판매액 평균'
                          FROM Orders);